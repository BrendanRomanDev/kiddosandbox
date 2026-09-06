class_name Player
extends CharacterBody2D

## Top-down 8-direction player controller.
##
## All animation here is procedural - it drives the transform of the Visual node
## rather than swapping sprite frames. That means the placeholder art can be
## replaced with anything (silhouette, rigged character, chibi sprite) without
## touching this script. Swap what lives under Visual, nothing else changes.
##
## Input comes from a PlayerInput bound to one device, so two players on one
## couch do not drive each other's character.

# --- Movement tuning ---
const MAX_SPEED := 150.0
const ACCELERATION := 1100.0
const FRICTION := 1500.0
## Ghosts drift rather than run - they are waiting for a revive, not fighting.
const DOWNED_SPEED_SCALE := 0.65

# --- Dodge tuning ---
const DODGE_SPEED := 400.0
const DODGE_DURATION := 0.30
const DODGE_COOLDOWN := 3.0
## Speed you carry out of a slide, decaying back to MAX_SPEED over the boost window.
const DODGE_BOOST_SPEED := 210.0
const DODGE_BOOST_DURATION := 0.35

# --- Damage ---
const HIT_INVULNERABLE_TIME := 0.9
const HIT_FLASH_INTERVAL := 0.07

# --- Procedural animation tuning ---
const IDLE_BOB_SPEED := 3.0
const IDLE_BOB_AMOUNT := 0.035
const RUN_BOB_SPEED := 14.0
const RUN_BOB_AMOUNT := 0.11
const RUN_HOP_HEIGHT := 1.5
## Stretch along the direction of travel during a slide.
const DODGE_SMEAR_AMOUNT := 0.34
## Uniform flatten during a slide, so diagonals still read as a dodge.
const DODGE_CROUCH_AMOUNT := 0.14
const SETTLE_SPEED := 18.0

# --- Facing ---
const DIRECTION_COUNT := 8

## Emitted when the snapped 8-way facing changes. Sprite swapping will hang off
## this once real directional art exists.
signal facing_changed(facing: Vector2)
signal went_down
signal revived

## Which device drives this player. -1 is keyboard; 0, 1, 2... are joypads in
## connection order. Set per instance in the scene.
@export var device := PlayerInput.KEYBOARD
@export var player_index := 1
## Tints the placeholder sprite so the two players are told apart at a glance.
## Goes away once real per-character art exists.
@export var player_color := Color(0.24, 0.85, 0.72)

@onready var _visual: Node2D = $Visual
@onready var _health: Health = $Health
@onready var _weapon: Weapon = $Weapon

var _input_source: PlayerInput
var _facing := Vector2.DOWN
var _bob_time := 0.0
var _dodge_time_left := 0.0
var _dodge_cooldown_left := 0.0
var _dodge_direction := Vector2.ZERO
var _boost_time_left := 0.0
var _invulnerable_time_left := 0.0
var _is_down := false


func _ready() -> void:
	add_to_group("players")
	collision_layer = CollisionLayers.PLAYER
	collision_mask = CollisionLayers.WORLD

	_input_source = PlayerInput.new(device)
	_health.died.connect(_on_died)
	($Visual/Sprite as Sprite2D).modulate = player_color


func _physics_process(delta: float) -> void:
	_input_source.update()
	_dodge_cooldown_left = maxf(_dodge_cooldown_left - delta, 0.0)
	_invulnerable_time_left = maxf(_invulnerable_time_left - delta, 0.0)
	_update_invulnerable_flash()

	var is_dodging := _dodge_time_left > 0.0
	if is_dodging:
		_process_dodge(delta)
		_update_dodge_visual()
		move_and_slide()
		return

	_boost_time_left = maxf(_boost_time_left - delta, 0.0)
	_process_movement(delta)
	_process_shooting()
	_update_grounded_visual(delta)
	move_and_slide()


# --- Movement ---

func _process_movement(delta: float) -> void:
	var input_direction := _input_source.get_move_vector()

	if _input_source.wants_dodge() and is_dodge_ready() and not _is_down:
		_start_dodge(input_direction)
		return

	var is_moving := not input_direction.is_zero_approx()
	if is_moving:
		_set_facing(_snap_to_eight(input_direction))
		velocity = velocity.move_toward(input_direction * _get_speed_cap(), ACCELERATION * delta)
		return

	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)


## Normal top speed, raised briefly after a slide so the dodge launches you.
func _get_speed_cap() -> float:
	var cap := MAX_SPEED
	if _boost_time_left > 0.0:
		var boost_remaining := _boost_time_left / DODGE_BOOST_DURATION
		cap = lerpf(MAX_SPEED, DODGE_BOOST_SPEED, boost_remaining)

	return cap * DOWNED_SPEED_SCALE if _is_down else cap


# --- Shooting ---

func _process_shooting() -> void:
	if _is_down or not _input_source.is_shooting():
		return

	_weapon.try_fire(_input_source.get_aim_vector(), _facing)


# --- Dodge ---

func _start_dodge(input_direction: Vector2) -> void:
	# Dodging with no stick input slides the way you are already facing.
	_dodge_direction = input_direction.normalized() if not input_direction.is_zero_approx() else _facing
	_set_facing(_snap_to_eight(_dodge_direction))
	_dodge_time_left = DODGE_DURATION
	_dodge_cooldown_left = DODGE_COOLDOWN
	velocity = _dodge_direction * DODGE_SPEED


func _process_dodge(delta: float) -> void:
	_dodge_time_left = maxf(_dodge_time_left - delta, 0.0)

	var is_dodge_finished := _dodge_time_left <= 0.0
	if is_dodge_finished:
		_boost_time_left = DODGE_BOOST_DURATION
		velocity = _dodge_direction * DODGE_BOOST_SPEED
		return

	# Ease out of the burst so the slide settles into the boost rather than
	# stopping dead.
	var progress := _get_dodge_progress()
	velocity = _dodge_direction * lerpf(DODGE_SPEED, DODGE_BOOST_SPEED, progress)


func _get_dodge_progress() -> float:
	return 1.0 - (_dodge_time_left / DODGE_DURATION)


# --- Damage ---

## Projectiles call this rather than touching Health directly, so i-frames are
## enforced in one place.
func try_take_damage(amount: int) -> void:
	if is_invulnerable():
		return

	_health.take_damage(amount)
	_invulnerable_time_left = HIT_INVULNERABLE_TIME


func is_invulnerable() -> bool:
	return is_dodging() or _is_down or _invulnerable_time_left > 0.0


func _update_invulnerable_flash() -> void:
	if _is_down:
		return

	var is_flashing := _invulnerable_time_left > 0.0
	if not is_flashing:
		_visual.modulate.a = 1.0
		return

	var flash_step := int(_invulnerable_time_left / HIT_FLASH_INTERVAL)
	_visual.modulate.a = 0.35 if flash_step % 2 == 0 else 1.0


func _on_died() -> void:
	_is_down = true
	_visual.modulate.a = 0.4
	went_down.emit()


## Called when the fight is won - GDD has downed players revive on boss defeat
## rather than the run ending.
func revive(health_amount := 3) -> void:
	if not _is_down:
		return

	_is_down = false
	_visual.modulate.a = 1.0
	_health.heal(health_amount)
	_invulnerable_time_left = HIT_INVULNERABLE_TIME
	revived.emit()


# --- Procedural animation ---

func _update_dodge_visual() -> void:
	# sin() gives a 0 -> 1 -> 0 curve, so the smear peaks mid-slide and settles.
	var smear := sin(_get_dodge_progress() * PI)

	# Stretch along the direction of travel and compress across it. No rotation,
	# so a slide reads the same whichever of the 8 directions you take. Cardinals
	# get the full smear; diagonals cancel out to the crouch alone.
	var travel_axis := absf(_dodge_direction.x) - absf(_dodge_direction.y)
	var crouch := 1.0 - smear * DODGE_CROUCH_AMOUNT

	_visual.scale = Vector2(
		1.0 + smear * DODGE_SMEAR_AMOUNT * travel_axis,
		1.0 - smear * DODGE_SMEAR_AMOUNT * travel_axis
	) * crouch
	_visual.position.y = 0.0
	_visual.rotation = 0.0


func _update_grounded_visual(delta: float) -> void:
	var is_moving := velocity.length() > 1.0
	var bob_speed := RUN_BOB_SPEED if is_moving else IDLE_BOB_SPEED
	var bob_amount := RUN_BOB_AMOUNT if is_moving else IDLE_BOB_AMOUNT

	_bob_time += delta * bob_speed
	var bob := sin(_bob_time)

	# Squash and stretch are inverse - the character keeps its volume.
	var target_scale := Vector2(1.0 - bob * bob_amount, 1.0 + bob * bob_amount)
	var target_hop := -absf(bob) * RUN_HOP_HEIGHT if is_moving else 0.0

	_visual.scale = _visual.scale.lerp(target_scale, SETTLE_SPEED * delta)
	_visual.position.y = lerpf(_visual.position.y, target_hop, SETTLE_SPEED * delta)


# --- Facing ---

func _set_facing(new_facing: Vector2) -> void:
	if new_facing.is_equal_approx(_facing):
		return

	_facing = new_facing
	facing_changed.emit(_facing)


## Snaps an analog stick vector to one of 8 compass directions. Movement itself
## stays fully analog - this is only the facing used for art selection.
func _snap_to_eight(direction: Vector2) -> Vector2:
	if direction.is_zero_approx():
		return _facing

	var step := TAU / DIRECTION_COUNT
	return Vector2.RIGHT.rotated(snappedf(direction.angle(), step))


# --- Public state ---

func get_facing() -> Vector2:
	return _facing


## 0.0 the instant a dodge is spent, 1.0 once it is ready again. Drives the
## cooldown indicator.
func get_dodge_cooldown_ratio() -> float:
	return 1.0 - (_dodge_cooldown_left / DODGE_COOLDOWN)


func is_dodge_ready() -> bool:
	return _dodge_cooldown_left <= 0.0


func is_dodging() -> bool:
	return _dodge_time_left > 0.0


func is_down() -> bool:
	return _is_down
