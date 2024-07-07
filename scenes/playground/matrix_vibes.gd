extends Node3D

@export_range(0.0, 1.0, 0.01) var speed = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = speed
	$ShaderAdjuster.speed_scale = clampf(speed * 3, 0.0, 1.0)
	$AnimationPlayer.play("Rotate")
	$ShaderAdjuster.play("Pixelation")
