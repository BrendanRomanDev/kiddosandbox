class_name PlayerInput
extends RefCounted

## Input for exactly one player, read from exactly one device.
##
## Input.get_vector() merges every connected device into one reading, which is
## fine solo and useless in couch co-op - both players would drive both
## characters. This reads a specific joypad by id instead, or falls back to the
## keyboard action map when the device is KEYBOARD.
##
## update() must be called once per physics frame before the getters, because
## joypad buttons have no built-in "just pressed" edge like actions do.

const KEYBOARD := -1
const STICK_DEADZONE := 0.2
const TRIGGER_THRESHOLD := 0.4

var device := KEYBOARD

var _dodge_held := false
var _dodge_was_held := false


func _init(device_id := KEYBOARD) -> void:
	device = device_id


func update() -> void:
	_dodge_was_held = _dodge_held
	_dodge_held = _read_dodge_held()


func get_move_vector() -> Vector2:
	if _is_keyboard():
		return Input.get_vector("move_left", "move_right", "move_up", "move_down")

	return _apply_deadzone(Vector2(
		Input.get_joy_axis(device, JOY_AXIS_LEFT_X),
		Input.get_joy_axis(device, JOY_AXIS_LEFT_Y)
	))


## Right stick. Zero when the player is not actively aiming, which is the
## normal case - auto-aim covers it.
func get_aim_vector() -> Vector2:
	if _is_keyboard():
		return Vector2.ZERO

	return _apply_deadzone(Vector2(
		Input.get_joy_axis(device, JOY_AXIS_RIGHT_X),
		Input.get_joy_axis(device, JOY_AXIS_RIGHT_Y)
	))


## Held rather than tapped, so holding the trigger keeps firing.
func is_shooting() -> bool:
	if _is_keyboard():
		return Input.is_action_pressed("shoot")

	return Input.get_joy_axis(device, JOY_AXIS_TRIGGER_RIGHT) >= TRIGGER_THRESHOLD


func wants_dodge() -> bool:
	return _dodge_held and not _dodge_was_held


func _read_dodge_held() -> bool:
	if _is_keyboard():
		return Input.is_action_pressed("dodge")

	return Input.is_joy_button_pressed(device, JOY_BUTTON_RIGHT_SHOULDER) \
		or Input.is_joy_button_pressed(device, JOY_BUTTON_B)


func _is_keyboard() -> bool:
	return device == KEYBOARD


func _apply_deadzone(raw: Vector2) -> Vector2:
	return raw if raw.length() >= STICK_DEADZONE else Vector2.ZERO
