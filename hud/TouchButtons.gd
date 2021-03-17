extends Node2D


func _ready():
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y - (get_viewport_rect().size.y / 6)
