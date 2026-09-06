extends Camera2D

## Shared camera that keeps every living player framed.
##
## GDD Epic 4 left "split/shared camera" open. Shared wins for a single-arena
## boss fight - split screen would hand each player half the resolution to look
## at the same room. It also keeps the pair together, which matters when one of
## them is three years old and wanders.
##
## Follows the midpoint of all players and pulls back as they separate.

const PLAYER_GROUP := "players"
const MIN_ZOOM := 2.0
const MAX_ZOOM := 4.0
const EDGE_PADDING := 110.0
const FOLLOW_SPEED := 6.0
const ZOOM_SPEED := 3.5


func _ready() -> void:
	make_current()


func _physics_process(delta: float) -> void:
	var players := get_tree().get_nodes_in_group(PLAYER_GROUP)
	if players.is_empty():
		return

	var bounds := _get_player_bounds(players)
	global_position = global_position.lerp(bounds.get_center(), FOLLOW_SPEED * delta)

	var target_zoom := Vector2.ONE * _get_fitting_zoom(bounds)
	zoom = zoom.lerp(target_zoom, ZOOM_SPEED * delta)


func _get_player_bounds(players: Array) -> Rect2:
	var bounds := Rect2()
	var has_first := false

	for candidate in players:
		var player := candidate as Node2D
		if player == null:
			continue

		if not has_first:
			bounds = Rect2(player.global_position, Vector2.ZERO)
			has_first = true
			continue

		bounds = bounds.expand(player.global_position)

	return bounds


## Widest zoom that still fits both players plus padding, clamped so the view
## never gets uselessly far out or uncomfortably tight.
func _get_fitting_zoom(bounds: Rect2) -> float:
	var viewport_size := get_viewport_rect().size
	var required := bounds.size + Vector2.ONE * EDGE_PADDING * 2.0
	var fit := minf(
		viewport_size.x / maxf(required.x, 1.0),
		viewport_size.y / maxf(required.y, 1.0)
	)
	return clampf(fit, MIN_ZOOM, MAX_ZOOM)
