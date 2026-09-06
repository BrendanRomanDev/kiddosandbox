class_name Projectile
extends Area2D

## A single bullet. Travels in a straight line until it hits something, leaves
## the arena, or times out.
##
## Every bullet is instantiated and freed individually. That is fine at the
## densities a pre-MVP boss fight produces; if patterns ever get thick enough
## to stutter, this is the first thing to pool.

const DEFAULT_SPEED := 260.0
const DEFAULT_DAMAGE := 1
const DEFAULT_LIFETIME := 4.0
const SPAWN_SCALE := 0.4
const SPAWN_POP_TIME := 0.08

var speed := DEFAULT_SPEED
var damage := DEFAULT_DAMAGE
var lifetime := DEFAULT_LIFETIME

var _direction := Vector2.RIGHT
var _age := 0.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	# Small pop on spawn so bullets read as appearing rather than blinking in.
	var visual: Node2D = $Visual
	visual.scale = Vector2.ONE * SPAWN_SCALE
	create_tween().tween_property(visual, "scale", Vector2.ONE, SPAWN_POP_TIME)


func _physics_process(delta: float) -> void:
	_age += delta
	if _age >= lifetime:
		queue_free()
		return

	position += _direction * speed * delta


## Call after add_child(), so global_position lands where you expect rather
## than being reinterpreted as a local offset.
func launch(origin: Vector2, direction: Vector2) -> void:
	global_position = origin
	_direction = direction.normalized()
	rotation = _direction.angle()


func _on_body_entered(body: Node2D) -> void:
	_apply_damage_to(body)
	queue_free()


func _apply_damage_to(body: Node2D) -> void:
	if body.has_method("try_take_damage"):
		body.try_take_damage(damage)
		return

	var health := body.get_node_or_null("Health") as Health
	if health != null:
		health.take_damage(damage)
