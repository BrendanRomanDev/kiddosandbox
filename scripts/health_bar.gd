extends Node2D

## Floating bar above an entity, driven by a Health node.
##
## Parent this to the entity rather than its Visual node - anything under
## Visual inherits squash-and-stretch, and a deforming health bar reads as a
## rendering bug.

@export var health_path: NodePath = ^"../Health"
@export var bar_size := Vector2(22.0, 2.5)
@export var bar_offset_y := -22.0
@export var fill_color := Color(0.95, 0.35, 0.4)
@export var hide_when_full := false

const COLOR_TRACK := Color(0.0, 0.0, 0.0, 0.5)

var _health: Health
var _last_ratio := -1.0


func _ready() -> void:
	_health = get_node_or_null(health_path) as Health
	if _health == null:
		push_warning("HealthBar at %s found no Health at '%s'" % [get_path(), health_path])
		set_process(false)


func _process(_delta: float) -> void:
	var ratio := _health.get_ratio()
	if is_equal_approx(ratio, _last_ratio):
		return

	_last_ratio = ratio
	queue_redraw()


func _draw() -> void:
	if hide_when_full and is_equal_approx(_last_ratio, 1.0):
		return

	var origin := Vector2(-bar_size.x * 0.5, bar_offset_y)
	draw_rect(Rect2(origin, bar_size), COLOR_TRACK)

	var fill_width := bar_size.x * clampf(_last_ratio, 0.0, 1.0)
	draw_rect(Rect2(origin, Vector2(fill_width, bar_size.y)), fill_color)
