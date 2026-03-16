class_name CameraPanner 
extends Node

@export var camera:Camera2D

@export var zoom_range := Vector2(0.5, 2)
@export var zoom_step := 0.05
@export var zoom_relative = true

var dragging := false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			dragging = event.pressed
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_in_relative() if zoom_relative else zoom_in()
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_out_relative() if zoom_relative else zoom_out()
	
	if event is InputEventMouseMotion and dragging:
		drag(event.relative)

func zoom_in():
	camera.zoom += Vector2.ONE * zoom_step
	camera.zoom = camera.zoom.clamp(Vector2.ONE * zoom_range.x, Vector2.ONE * zoom_range.y)

func zoom_out():
	camera.zoom -= Vector2.ONE * zoom_step
	camera.zoom = camera.zoom.clamp(Vector2.ONE * zoom_range.x, Vector2.ONE * zoom_range.y)

func zoom_in_relative():
	var mouse_before := camera.get_global_mouse_position()
	zoom_in()
	var mouse_after := camera.get_global_mouse_position()
	camera.position += mouse_before - mouse_after

func zoom_out_relative():
	var mouse_before := camera.get_global_mouse_position()
	zoom_out()
	var mouse_after := camera.get_global_mouse_position()
	camera.position += mouse_before - mouse_after

func drag(relative:Vector2):
	camera.position -= relative/camera.zoom
