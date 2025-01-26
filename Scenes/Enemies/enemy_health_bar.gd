extends TextureProgressBar

var enemy
func _ready():
	enemy = get_parent()
	value = enemy.health * 100 / enemy.max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func update():
	enemy = get_parent()
	value = enemy.health * 100 / enemy.max_health
