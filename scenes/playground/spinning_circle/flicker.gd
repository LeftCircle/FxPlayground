extends Node
class_name Flicker

@export var node_to_flicker : Node
@export_range(0, 2) var speed_multiplier : float = 1.0
@export var flicker_per_second : float = 1.0
@export var max_flicker_speed : float = 10.0
@export_range(0, 0.1, 0.0001) var flicker_time : float = 0.1


func _ready() -> void:
	flicker()

func flicker() -> void:
	# Cause the node to flicker x times per second by changing its visibility
	node_to_flicker.visible = not node_to_flicker.visible
	# await get_tree().create_timer(flicker_time).timeout
	# node_to_flicker.visible = not node_to_flicker.visible
	await get_tree().create_timer(1.0 / flicker_per_second).timeout
	flicker_per_second *= speed_multiplier
	if not flicker_per_second > max_flicker_speed:
		flicker()
