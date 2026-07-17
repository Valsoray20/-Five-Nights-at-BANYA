extends Label

var counter: int = 0
var timer: Timer
var is_subtracting: bool = false

func _ready() -> void:
	text = str(counter)
	print("Label готов, is_subtracting = ", is_subtracting)
	
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	print("Тик таймера, is_subtracting = ", is_subtracting, ", counter = ", counter)
	if is_subtracting:
		counter -= 1
	else:
		counter += 1
	text = str(counter)

func start_subtracting() -> void:
	print("start_subtracting() вызван")
	is_subtracting = true

func start_adding() -> void:
	print("start_adding() вызван")
	is_subtracting = false
