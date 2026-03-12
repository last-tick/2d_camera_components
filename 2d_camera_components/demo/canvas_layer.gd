extends CanvasLayer

@export var points_holder:Node2D
@export var container:Container
@export var camera_snapper:CameraSnapper

func _ready() -> void:
	for child in container.get_children():
		child.queue_free()
	
	for point in points_holder.get_children():
		var btn := Button.new()
		btn.text = point.name
		btn.pressed.connect(camera_snapper.move_to.bind(point, 1.0))
		container.add_child(btn)
