extends Label

var counter: int = 25
var timer: Timer
var open_count: int = 0

func _ready():
	text = str(counter)
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	if open_count > 0:
		counter = max(0, counter - open_count)
	else:
		counter += 1
	text = str(counter)

func window_opened():
	open_count += 1
	if open_count < 0: open_count = 0

func window_closed():
	open_count -= 1
	if open_count < 0: open_count = 0

func add_temperature(amount: int):
	counter += amount
	text = str(counter)
