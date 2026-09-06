class_name Weapon
extends Node2D

## Fires projectiles on a cooldown, with per-player auto-aim.
##
## Auto-aim strength is per-player by design (GDD: "auto-aim configurable per
## player, 0-100%"). 1.0 locks onto the nearest enemy, 0.0 is pure manual aim,
## and values between blend the two - so a 3-year-old can get full assistance
## in the same session where a parent gets none.

const PROJECTILE_SCENE := preload("res://scenes/projectile.tscn")
const ENEMY_GROUP := "enemies"
const PROJECTILE_CONTAINER_GROUP := "projectile_container"

@export_range(0.0, 1.0) var auto_aim_strength := 1.0
@export var fire_interval := 0.18
@export var projectile_speed := 300.0
@export var projectile_damage := 1
@export var muzzle_distance := 9.0

var _cooldown_left := 0.0


func _physics_process(delta: float) -> void:
	_cooldown_left = maxf(_cooldown_left - delta, 0.0)


func can_fire() -> bool:
	return _cooldown_left <= 0.0


## manual_aim is the right stick (usually zero). fallback_aim is the direction
## the character is facing, used when nothing else points anywhere.
func try_fire(manual_aim: Vector2, fallback_aim: Vector2) -> bool:
	if not can_fire():
		return false

	_fire(resolve_aim(manual_aim, fallback_aim))
	_cooldown_left = fire_interval
	return true


func resolve_aim(manual_aim: Vector2, fallback_aim: Vector2) -> Vector2:
	var base := manual_aim if not manual_aim.is_zero_approx() else fallback_aim
	if base.is_zero_approx():
		base = Vector2.DOWN
	base = base.normalized()

	var target := find_nearest_enemy()
	if target == null or auto_aim_strength <= 0.0:
		return base

	var to_target := (target.global_position - global_position).normalized()
	return base.slerp(to_target, auto_aim_strength).normalized()


func find_nearest_enemy() -> Node2D:
	var nearest: Node2D = null
	var nearest_distance := INF

	for candidate in get_tree().get_nodes_in_group(ENEMY_GROUP):
		var enemy := candidate as Node2D
		if enemy == null:
			continue

		var distance := global_position.distance_squared_to(enemy.global_position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest = enemy

	return nearest


func _fire(direction: Vector2) -> void:
	var bullet: Projectile = PROJECTILE_SCENE.instantiate()
	bullet.speed = projectile_speed
	bullet.damage = projectile_damage
	bullet.collision_layer = CollisionLayers.PLAYER_BULLET
	bullet.collision_mask = CollisionLayers.ENEMY | CollisionLayers.WORLD

	_get_projectile_parent().add_child(bullet)
	bullet.launch(global_position + direction * muzzle_distance, direction)


func _get_projectile_parent() -> Node:
	var container := get_tree().get_first_node_in_group(PROJECTILE_CONTAINER_GROUP)
	return container if container != null else get_tree().current_scene
