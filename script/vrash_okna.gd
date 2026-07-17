extends Node3D

@export var open_angle_degrees: float = 30.0
@export var open_duration: float = 0.5
@export var counter_label: Label

var is_open: bool = false
var tween: Tween
var initial_rotation_x: float

func _ready():
	initial_rotation_x = rotation.x

func interact():
	if tween and tween.is_running():
		return

	if is_open:
		close()
	else:
		open()

func open():
	is_open = true
	tween = create_tween()
	tween.tween_property(self, "rotation:x", initial_rotation_x + deg_to_rad(open_angle_degrees), open_duration)
	
	if counter_label:
		print("Окно открылось, вызываем start_subtracting()")
		counter_label.start_subtracting()
	else:
		print("ОШИБКА: counter_label не назначен!")

func close():
	is_open = false
	tween = create_tween()
	tween.tween_property(self, "rotation:x", initial_rotation_x, open_duration)
	
	if counter_label:
		print("Окно закрылось, вызываем start_adding()")
		counter_label.start_adding()
	else:
		print("ОШИБКА: counter_label не назначен!")
