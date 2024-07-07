extends Node3D
class_name Rotation3D

@export var rotation_speed: float = 0.1
@export var rotation_axis: Vector3 = Vector3(0, 1, 0)

func _process(delta: float) -> void:
	rotate_object_local(rotation_axis, rotation_speed * delta)

