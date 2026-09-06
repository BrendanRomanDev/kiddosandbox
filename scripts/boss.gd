extends CharacterBody2D

## Placeholder boss that cycles bullet patterns.
##
## Stands in for the modular boss-creator entity from the GDD. The patterns
## here are the vocabulary the creator will eventually assemble from parts -
## keeping them as separate, self-contained emitters now means the creator can
## later pick from them without this script being rewritten.

enum Pattern { RADIAL, AIMED, SPIRAL }

const PROJECTILE_SCENE := preload("res://scenes/projectile.tscn")
const PLAYER_GROUP := "players"
const PROJECTILE_CONTAINER_GROUP := "projectile_container"

const PATTERN_SEQUENCE: Array[Pattern] = [Pattern.RADIAL, Pattern.AIMED, Pattern.SPIRAL]
const PATTERN_DURATION := 3.2

const RADIAL_BULLET_COUNT := 14
const RADIAL_INTERVAL := 1.1
const RADIAL_SPEED := 95.0

const AIMED_BURST_COUNT := 3
const AIMED_SPREAD_RADIANS := 0.22
const AIMED_INTERVAL := 0.85
const AIMED_SPEED := 165.0

const SPIRAL_ARM_COUNT := 2
const SPIRAL_INTERVAL := 0.08
const SPIRAL_SPEED := 120.0
const SPIRAL_ADVANCE_RADIANS := 0.38

const HIT_FLASH_TIME := 0.09

signal pattern_changed(pattern: Pattern)

@onready var _health: Health = $Health
@onready var _visual: Node2D = $Visual

var _pattern_index := 0
var _pattern_time_left := PATTERN_DURATION
var _fire_time_left := 0.0
var _spiral_angle := 0.0


func _ready() -> void:
	add_to_group("enemies")
	collision_layer = CollisionLayers.ENEMY
	collision_mask = CollisionLayers.WORLD

	_health.died.connect(_on_died)
	_health.damaged.connect(_on_damaged)
	# Open fire immediately rather than idling for a full interval first, which
	# matches how every later pattern starts (see _advance_pattern).
	_fire_time_left = 0.0


func _physics_process(delta: float) -> void:
	if _health.is_dead():
		return

	_advance_pattern(delta)

	_fire_time_left -= delta
	if _fire_time_left <= 0.0:
		_emit_current_pattern()
		_fire_time_left = _get_current_interval()


func _advance_pattern(delta: float) -> void:
	_pattern_time_left -= delta
	if _pattern_time_left > 0.0:
		return

	_pattern_index = (_pattern_index + 1) % PATTERN_SEQUENCE.size()
	_pattern_time_left = PATTERN_DURATION
	_fire_time_left = 0.0
	pattern_changed.emit(get_current_pattern())


func get_current_pattern() -> Pattern:
	return PATTERN_SEQUENCE[_pattern_index]


func _get_current_interval() -> float:
	match get_current_pattern():
		Pattern.RADIAL:
			return RADIAL_INTERVAL
		Pattern.AIMED:
			return AIMED_INTERVAL
		_:
			return SPIRAL_INTERVAL


# --- Patterns ---

func _emit_current_pattern() -> void:
	match get_current_pattern():
		Pattern.RADIAL:
			_emit_radial()
		Pattern.AIMED:
			_emit_aimed()
		Pattern.SPIRAL:
			_emit_spiral()


## Even ring in every direction. Punishes standing still, easy to walk out of.
func _emit_radial() -> void:
	var step := TAU / RADIAL_BULLET_COUNT
	for i in RADIAL_BULLET_COUNT:
		_spawn_bullet(Vector2.RIGHT.rotated(step * i), RADIAL_SPEED)


## Short spread aimed at whoever is closest. The pattern that actually chases.
func _emit_aimed() -> void:
	var target := _find_nearest_player()
	if target == null:
		return

	var to_target := (target.global_position - global_position).normalized()
	var first_offset := -AIMED_SPREAD_RADIANS * (AIMED_BURST_COUNT - 1) * 0.5
	for i in AIMED_BURST_COUNT:
		var angle := first_offset + AIMED_SPREAD_RADIANS * i
		_spawn_bullet(to_target.rotated(angle), AIMED_SPEED)


## Slowly rotating arms. Creates lanes to move through rather than dodge.
func _emit_spiral() -> void:
	var step := TAU / SPIRAL_ARM_COUNT
	for i in SPIRAL_ARM_COUNT:
		_spawn_bullet(Vector2.RIGHT.rotated(_spiral_angle + step * i), SPIRAL_SPEED)

	_spiral_angle = fmod(_spiral_angle + SPIRAL_ADVANCE_RADIANS, TAU)


func _spawn_bullet(direction: Vector2, speed: float) -> void:
	var bullet: Projectile = PROJECTILE_SCENE.instantiate()
	bullet.speed = speed
	bullet.damage = 1
	bullet.collision_layer = CollisionLayers.ENEMY_BULLET
	bullet.collision_mask = CollisionLayers.PLAYER | CollisionLayers.WORLD
	bullet.modulate = Color(1.0, 0.45, 0.4)

	_get_projectile_parent().add_child(bullet)
	bullet.launch(global_position + direction * 12.0, direction)


func _find_nearest_player() -> Node2D:
	var nearest: Node2D = null
	var nearest_distance := INF

	for candidate in get_tree().get_nodes_in_group(PLAYER_GROUP):
		var player := candidate as Node2D
		if player == null or (player.has_method("is_down") and player.is_down()):
			continue

		var distance := global_position.distance_squared_to(player.global_position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest = player

	return nearest


func _get_projectile_parent() -> Node:
	var container := get_tree().get_first_node_in_group(PROJECTILE_CONTAINER_GROUP)
	return container if container != null else get_tree().current_scene


# --- Damage feedback ---

func _on_damaged(_amount: int, _remaining: int) -> void:
	var flash := create_tween()
	flash.tween_property(_visual, "modulate", Color(2.0, 2.0, 2.0), HIT_FLASH_TIME * 0.4)
	flash.tween_property(_visual, "modulate", Color.WHITE, HIT_FLASH_TIME)


func _on_died() -> void:
	remove_from_group("enemies")
	var death := create_tween()
	death.set_parallel(true)
	death.tween_property(_visual, "scale", Vector2(1.6, 0.2), 0.25)
	death.tween_property(_visual, "modulate:a", 0.0, 0.25)
	death.chain().tween_callback(queue_free)
