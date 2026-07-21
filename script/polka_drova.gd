extends StaticBody3D

@export var log_meshes: Array[MeshInstance3D]

var current_logs: int = 0

func _ready():
	current_logs = log_meshes.size()
	update_visibility()

func can_take_log() -> bool:
	return current_logs > 0

func remove_one_log():
	if current_logs <= 0:
		return
	current_logs -= 1
	update_visibility()

func update_visibility():
	for i in range(log_meshes.size()):
		log_meshes[i].visible = i < current_logs
