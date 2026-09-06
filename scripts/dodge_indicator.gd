extends Node2D

## Dodge cooldown bar, drawn just below the player's feet.
##
## Deliberately parented to Player rather than Visual - anything under Visual
## gets squashed by the dodge animation, and a stretching UI bar looks broken.
## Per-player rather than a screen HUD so it still works in 2P co-op.

const BAR_SIZE := Vector2(16.0, 2.0)
const BAR_OFFSET_Y := 5.0
const COLOR_TRACK := Color(0.0, 0.0, 0.0, 0.5)
const COLOR_CHARGING := Color(0.95, 0.62, 0.35, 0.95)
const COLOR_READY := Color(0.24, 0.85, 0.72, 1.0)

@onready var _player: Player = get_parent() as Player

var _last_ratio := -1.0


func _process(_delta: float) -> void:
	# Only redraw when the fill actually moves - otherwise this is a static bar
	# being rebuilt every frame for nothing.
	var ratio := _player.get_dodge_cooldown_ratio()
	if is_equal_approx(ratio, _last_ratio):
		return

	_last_ratio = ratio
	queue_redraw()


func _draw() -> void:
	var origin := Vector2(-BAR_SIZE.x * 0.5, BAR_OFFSET_Y)
	draw_rect(Rect2(origin, BAR_SIZE), COLOR_TRACK)

	var fill_color := COLOR_READY if _player.is_dodge_ready() else COLOR_CHARGING
	var fill_width := BAR_SIZE.x * clampf(_last_ratio, 0.0, 1.0)
	draw_rect(Rect2(origin, Vector2(fill_width, BAR_SIZE.y)), fill_color)
