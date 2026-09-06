class_name CollisionLayers

## Named physics layer bits, so nothing in the project sets a raw mask number.
## Mirrors the layer_names block in project.godot - keep the two in step.

const WORLD := 1 << 0
const PLAYER := 1 << 1
const ENEMY := 1 << 2
const PLAYER_BULLET := 1 << 3
const ENEMY_BULLET := 1 << 4
