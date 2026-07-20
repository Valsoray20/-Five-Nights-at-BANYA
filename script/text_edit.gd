extends Label

var counter: int = 25
var timer: Timer
var open_count: int = 0

func _ready() -> void:
	text = str(counter)
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	if open_count > 0:
		if counter > 0:
			counter -= open_count
	else:
		counter += 1
	if counter < 0:
		counter = 0
	text = str(counter)

func window_opened() -> void:
	open_count += 1
	if open_count < 0:
		open_count = 0

func window_closed() -> void:
	open_count -= 1
	if open_count < 0:
		open_count = 0

func add_temperature(amount: int) -> void:
	counter += amount
	text = str(counter)
