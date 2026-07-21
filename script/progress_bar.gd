extends ProgressBar

func set_heat_progress(ratio: float):
	value = clamp(ratio, 0.0, 1.0)

func reset_heat():
	value = 0.0
