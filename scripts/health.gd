class_name Health
extends Node

## Reusable hit points for anything that can be damaged. Players and bosses
## both mount one of these rather than tracking hp on their own scripts.

signal damaged(amount: int, remaining: int)
signal healed(amount: int, remaining: int)
signal died

@export var max_health := 6

var _current := 0


func _ready() -> void:
	_current = max_health


func take_damage(amount: int) -> void:
	if is_dead() or amount <= 0:
		return

	_current = maxi(_current - amount, 0)
	damaged.emit(amount, _current)

	if _current == 0:
		died.emit()


func heal(amount: int) -> void:
	if is_dead() or amount <= 0:
		return

	_current = mini(_current + amount, max_health)
	healed.emit(amount, _current)


func get_current() -> int:
	return _current


func get_ratio() -> float:
	return float(_current) / float(max_health) if max_health > 0 else 0.0


func is_dead() -> bool:
	return _current <= 0
