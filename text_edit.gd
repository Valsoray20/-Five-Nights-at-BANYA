extends Label

var counter: int = 0
var timer: Timer
var open_count: int = 0  # Считаем сколько объектов открыто

func _ready() -> void:
	text = str(counter)
	
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	if open_count > 0:  # Если хотя бы одно окно/дверь открыты
		if counter > 0:
			counter -= open_count  # Вычитаем пропорционально количеству открытых
	else:
		counter += 1  # Всё закрыто — прибавляем
	text = str(counter)

func window_opened() -> void:
	open_count += 1

func window_closed() -> void:
	open_count -= 1
	if open_count < 0:
		open_count = 0
