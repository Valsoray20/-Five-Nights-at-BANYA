extends Node3D

@export var open_angle_degrees: float = 30.0
@export var open_duration: float = 0.5

var is_open: bool = false
var tween: Tween
var initial_rotation_y: float

func _ready():
	initial_rotation_y = rotation.y

func interact():
	if tween and tween.is_running():
		return   # предотвращаем повторное нажатие во время анимации

	if is_open:
		close()
	else:
		open()

func open():
	is_open = true
	tween = create_tween()
	tween.tween_property(self, "rotation:y", initial_rotation_y + deg_to_rad(open_angle_degrees), open_duration)

func close():
	is_open = false
	tween = create_tween()
	tween.tween_property(self, "rotation:y", initial_rotation_y, open_duration)
