class_name CameraSnapper
extends Node

@export var camera:Camera2D

var tween:Tween:
	set = tween_setter

func tween_setter(value):
	if tween != null and tween.is_valid():
		tween.kill()
	tween = value

func move_to(point:Node2D, zoom:float = -1):
	tween = create_tween()
	tween.tween_property(camera, "global_position", point.global_position, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	if zoom != -1:
		tween.parallel().tween_property(camera, "zoom", zoom*Vector2.ONE, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
