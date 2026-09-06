extends Node2D

## Debug marker showing which of the 8 directions the player is facing.
##
## This exists because a plain square (and, later, a plain silhouette) gives no
## directional read on its own. Delete this node once real facing art or an
## aiming weapon takes over the job.

@onready var _player: Player = get_parent() as Player


func _ready() -> void:
	_player.facing_changed.connect(_on_facing_changed)
	_on_facing_changed(_player.get_facing())


func _on_facing_changed(facing: Vector2) -> void:
	rotation = facing.angle()
