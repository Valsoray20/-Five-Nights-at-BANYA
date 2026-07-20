extends Node3D

signal camera_approached
signal camera_left

@export var camera_marker: Marker3D
@export var transition_duration: float = 0.8

var original_camera_transform: Transform3D
var is_viewing: bool = false
var tween: Tween

func interact():
	if is_viewing:
		return

	var cam = get_viewport().get_camera_3d()
	if not cam or not camera_marker:
		return

	original_camera_transform = cam.global_transform
	is_viewing = true

	tween = create_tween().set_parallel(true)
	tween.tween_property(cam, "global_position", camera_marker.global_position, transition_duration).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(cam, "global_rotation", camera_marker.global_rotation, transition_duration).set_ease(Tween.EASE_IN_OUT)
	tween.chain().tween_callback(func(): emit_signal("camera_approached"))

func _input(event):
	if not is_viewing:
		return

	if event.is_action_pressed("ui_cancel") or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed):
		exit_view()

func exit_view():
	emit_signal("camera_left")
	var cam = get_viewport().get_camera_3d()
	if cam and tween:
		tween.kill()
		tween = create_tween().set_parallel(true)
		tween.tween_property(cam, "global_position", original_camera_transform.origin, transition_duration).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(cam, "global_rotation", original_camera_transform.basis.get_euler(), transition_duration).set_ease(Tween.EASE_IN_OUT)
		tween.chain().tween_callback(func(): is_viewing = false)
