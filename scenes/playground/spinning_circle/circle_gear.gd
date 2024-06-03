extends Node2D


@export var spinning_circle_scene : PackedScene
@export var connector : PackedScene

@export_range(0, 500) var gear_radius : float = 250
@export_range(0, 250) var spinning_circle_radius : float = 100
@export_range(0, 10) var n_circles : int = 5
@export_range(0, 1) var pause_time = 0.1

func _ready() -> void:
	_spawn_circles()

func _spawn_circles() -> void:
	var angle = 0
	var angle_increment = 2 * PI / n_circles
	var circles : Array[SpinningCircle] = []
	for i in range(n_circles):
		var circle : SpinningCircle = spinning_circle_scene.instantiate()
		circle.position = Vector2(cos(angle) * gear_radius, sin(angle) * gear_radius)
		circle.radius = spinning_circle_radius
		circle.starting_angle = angle
		circle.rotations_per_second = randf_range(0.3, 0.6)
		add_child(circle)
		angle += angle_increment
		circles.append(circle)
	var connections : Array[ConnectingLine]
	for i in range(n_circles):
		var connector_instance : ConnectingLine = connector.instantiate()
		connector_instance.starting_node = circles[i].orbiting_circle
		connector_instance.ending_node = circles[(i + 1) % n_circles].orbiting_circle
		add_child(connector_instance)
		connections.append(connector_instance)
	for i in range(5):
		connections = await _create_connecions_between_connections(connections, true)
	connections = await _create_connecions_between_connections(connections, false)

func _create_connecions_between_connections(connections : Array[ConnectingLine], visible_midpoints : bool) -> Array[ConnectingLine]:
	var new_connections : Array[ConnectingLine] = []
	for i in range(connections.size()):
		var connector_instance : ConnectingLine = connector.instantiate()
		connector_instance.starting_node = connections[i].midpoint_circle
		connector_instance.ending_node = connections[(i + 1) % connections.size()].midpoint_circle
		connector_instance.show_circle = visible_midpoints
		add_child(connector_instance)
		new_connections.append(connector_instance)
		await get_tree().create_timer(pause_time).timeout
		pause_time *= 0.8
	return new_connections
