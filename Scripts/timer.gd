extends Node2D

@onready var path_barrel = preload("res://Scenes/Enemies/Pathspawner.tscn")
@onready var path_ketchup = preload("res://Scenes/Enemies/Pathspawner.tscn") # TODO

var lcg_seed = 1

func _ready():
	get_node("../GameStats").wave_start.connect(wave_start)

func wave_start():
	var wave = get_node("../GameStats").wave_current
	
	var enemy_count = 5 + floor(wave * wave / 2.71828) # number "e"
	for i in enemy_count:
		var type = lcg() % 2
		if type == 0:
			add_child(path_barrel.instantiate())
		else:
			add_child(path_ketchup.instantiate())
		await get_tree().create_timer(0.5).timeout
	get_node("../GameStats").on_wave_spawning_complete(enemy_count)

# Linear Congruential Generator, seed = (a * seed + c) % mod. glibc uses a, c and mod shown below
func lcg() -> int:
	lcg_seed = (25214903917 * lcg_seed + 11) % int(pow(2, 48))
	return lcg_seed
	
