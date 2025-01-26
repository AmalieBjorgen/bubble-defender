extends TextureProgressBar


func _ready() -> void:
	var game_stats = get_node("../../../GameStats")
	game_stats.pool_health_changed.connect(update)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update():
	var game_stats = get_node("../../../GameStats")
	value = game_stats.pool_health * 100 / game_stats.pool_health_max
