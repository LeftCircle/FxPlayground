@tool
extends Line2D
class_name ConnectingLine

@export var starting_node : Node2D
@export var ending_node : Node2D
@export var show_circle : bool = true

@onready var midpoint_circle = $Ellipse

func _ready() -> void:
	midpoint_circle.visible = show_circle
	global_position = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	_set_points()
	queue_redraw()

func _set_points() -> void:
	set_point_position(0, starting_node.global_position)
	set_point_position(1, ending_node.global_position)
	midpoint_circle.global_position = (starting_node.global_position + ending_node.global_position) / 2

