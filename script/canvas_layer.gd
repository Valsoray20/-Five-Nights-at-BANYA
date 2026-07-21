extends Control

@export var stove_node: Node

func _ready():
	hide()
	if stove_node:
		stove_node.camera_approached.connect(show)
		stove_node.camera_left.connect(hide)
