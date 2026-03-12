class_name CameraPannerMobile
extends Node

@export var camera: Camera2D
@export var zoom_range := Vector2(0.5, 2.0)

var touches: Dictionary = {}
var last_distance := 0.0
var last_center = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			touches[event.index] = event.position
		else:
			touches.erase(event.index)

	elif event is InputEventScreenDrag:
		touches[event.index] = event.position
		if touches.size() == 2:
			update_gesture()
		else:
			reset_gesture()

func update_gesture():
	var p = touches.values()
	var distance = max(p[0].distance_to(p[1]), 0.0001)
	var center = (p[0] + p[1]) * 0.5
	
	if last_distance == 0.0:
		last_distance = distance
		last_center = center
		return
	# ZOOM
	var center_before := camera.to_global(center)
	camera.zoom = camera.zoom / (last_distance / distance)
	camera.zoom = camera.zoom.clamp(Vector2.ONE * zoom_range.x, Vector2.ONE * zoom_range.y)
	var center_after := camera.to_global(center)
	camera.position += center_before - center_after
	# PAN 
	var delta = center - last_center
	camera.position -= delta / camera.zoom
	# update
	last_center = center
	last_distance = distance


func reset_gesture():
	last_distance = 0.0
	last_center = Vector2.ZERO
