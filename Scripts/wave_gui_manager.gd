extends FlowContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var s = get_node("../../GameStats")
	s.wave_timer_changed.connect(wave_timer_changed)
	s.wave_start.connect(wave_start)
	s.game_win.connect(game_win)
	wave_timer_changed()
	wave_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func wave_timer_changed():
	var s = get_node("../../GameStats")
	var time = s.wave_timer
	
	var w = "IN PROGRESS"
	if time > 0: w = str(time, " seconds")
	if time == 1: w = str(time, " second ")
	
	var n = get_node("CurrentWaveTimer")
	if time <= 5:
		n.set("theme_override_colors/font_color", Color(1.0, 0.0, 0.0, 1.0))
	else:
		n.set("theme_override_colors/font_color", Color(1.0, 1.0, 1.0, 1.0))
	n.text = w

func wave_start():
	var s = get_node("../../GameStats")
	get_node("CurrentWave").text = str("Wave ", s.wave_current, " of ", s.wave_max)

func game_win():
	var n = get_node("CurrentWaveTimer")
	n.set("theme_override_colors/font_color", Color(1.0, 0.7, 0.1, 1.0))
	n.text = "VICTORY!  "
