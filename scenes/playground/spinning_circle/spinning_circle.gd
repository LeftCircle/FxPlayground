@tool
extends Node2D
class_name SpinningCircle


@export_range(0, 2 * PI) var starting_angle : float = 0 : set = set_starting_angle
@export_range(0, 250) var radius : float = 100 : set = set_radius
@export_range(0, 3, 0.01) var rotations_per_second : float = 1

@onready var circle_node : Ellipse = $OuterCircle
@onready var orbiting_circle : Ellipse = $OrbitingCircle

var _starting_angle : float
var _starting_radius : float

func _ready() -> void:
	set_radius(_starting_radius)
	set_starting_angle(_starting_angle)

func _physics_process(delta: float) -> void:
	starting_angle += delta * rotations_per_second * 2 * PI
	_rotate_orbiting_circle(starting_angle)

func set_radius(value: float) -> void:
	radius = value
	_starting_radius = value
	if is_instance_valid(circle_node):
		circle_node.size.x = radius * 2
		circle_node.size.y = radius * 2
		circle_node.queue_redraw()
		init_orbitng_circle()

func set_starting_angle(value: float) -> void:
	_starting_angle = value
	if is_instance_valid(orbiting_circle):
		orbiting_circle.rotation = value
	starting_angle = value
	init_orbitng_circle()

func init_orbitng_circle() -> void:
	if is_instance_valid(orbiting_circle):
		_rotate_orbiting_circle(orbiting_circle.rotation)

func _rotate_orbiting_circle(angle : float) -> void:
	orbiting_circle.rotation = angle
	var x = cos(orbiting_circle.rotation) * _starting_radius
	var y = sin(orbiting_circle.rotation) * _starting_radius
	orbiting_circle.position = Vector2(x, y)
	orbiting_circle.queue_redraw()
