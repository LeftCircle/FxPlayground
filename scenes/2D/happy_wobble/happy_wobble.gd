@tool
extends Sprite2D


func _ready() -> void:
	_set_pivot_to_bottom_center()


func _set_pivot_to_bottom_center() -> void:
	offset = Vector2(0, -texture.get_size().y / 2.0)
