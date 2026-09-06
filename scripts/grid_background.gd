extends Node2D

## Reference grid so movement is readable without any real environment art.
## Purely a development aid - replace with real floor tiles later.

const CELL_SIZE := 16
const HALF_EXTENT_CELLS := 60
const LINE_COLOR := Color(1.0, 1.0, 1.0, 0.07)
const AXIS_COLOR := Color(1.0, 1.0, 1.0, 0.18)


func _draw() -> void:
	var half_extent := HALF_EXTENT_CELLS * CELL_SIZE

	for cell in range(-HALF_EXTENT_CELLS, HALF_EXTENT_CELLS + 1):
		var offset := cell * CELL_SIZE
		var color := AXIS_COLOR if cell == 0 else LINE_COLOR
		draw_line(Vector2(offset, -half_extent), Vector2(offset, half_extent), color)
		draw_line(Vector2(-half_extent, offset), Vector2(half_extent, offset), color)
