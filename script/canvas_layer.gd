extends Control

@export var button: Button
@export var progress_bar: ProgressBar
@export var target_label: Label
@export var stove_node: Node

var hold_time: float = 0.0
const REQUIRED_TIME: float = 5.0
const HEAT_AMOUNT: int = 10

func _ready():
	hide()
	if stove_node:
		stove_node.camera_approached.connect(_on_camera_approached)
		stove_node.camera_left.connect(_on_camera_left)
	if button:
		button.pressed.connect(_reset_hold)

func _process(delta):
	if button and button.is_pressed():
		hold_time += delta
		if progress_bar:
			progress_bar.value = hold_time / REQUIRED_TIME
		if hold_time >= REQUIRED_TIME:
			hold_time = 0.0
			if target_label and target_label.has_method("add_temperature"):
				target_label.add_temperature(HEAT_AMOUNT)
			if progress_bar:
				progress_bar.value = 0.0
	else:
		hold_time = 0.0
		if progress_bar:
			progress_bar.value = 0.0

func _on_camera_approached():
	show()
	hold_time = 0.0
	if progress_bar:
		progress_bar.value = 0.0

func _on_camera_left():
	hide()
	hold_time = 0.0

func _reset_hold():
	hold_time = 0.0
	if progress_bar:
		progress_bar.value = 0.0
