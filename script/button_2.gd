extends Button

@export var stove_node: Node3D

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if stove_node and stove_node.has_method("exit_view"):
		stove_node.exit_view()
