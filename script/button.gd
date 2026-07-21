extends Button

@export var progress_bar: ProgressBar
@export var firewood_shelf: Node
@export var target_label: Label

var hold_time: float = 0.0
const REQUIRED_TIME: float = 5.0
const HEAT_AMOUNT: int = 10

func _process(delta):
	if is_pressed():
		hold_time += delta
		if progress_bar:
			progress_bar.value = hold_time / REQUIRED_TIME
		if hold_time >= REQUIRED_TIME:
			# Попытаться взять бревно и нагреть
			if firewood_shelf and firewood_shelf.has_method("can_take_log") and firewood_shelf.can_take_log():
				firewood_shelf.remove_one_log()
				if target_label and target_label.has_method("add_temperature"):
					target_label.add_temperature(HEAT_AMOUNT)
			# Сброс после полного цикла
			hold_time = 0.0
			if progress_bar:
				progress_bar.value = 0.0
	else:
		hold_time = 0.0
		if progress_bar:
			progress_bar.value = 0.0
