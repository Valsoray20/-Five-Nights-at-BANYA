extends Camera3D

@export var mouse_sensitivity: float = 0.1
@export var yaw_limit_degrees: float = 80.0

var initial_yaw: float
var yaw: float = 0.0
var yaw_limit: float

func _ready():
	initial_yaw = rotation.y
	yaw_limit = deg_to_rad(yaw_limit_degrees)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = event.position
		var from = project_ray_origin(mouse_pos)
		var dir = project_ray_normal(mouse_pos)

		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, from + dir * 10.0)
		query.collide_with_areas = true
		query.collide_with_bodies = true

		var result = space_state.intersect_ray(query)
		if result:
			var collider = result.collider
			if collider.has_method("interact"):
				collider.interact()
			elif collider is Node3D and collider.get_parent().has_method("interact"):
				collider.get_parent().interact()
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity * 0.01
		yaw = clampf(yaw, -yaw_limit, yaw_limit)
		rotation.y = initial_yaw + yaw

	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
