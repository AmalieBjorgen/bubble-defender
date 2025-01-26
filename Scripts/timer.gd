extends Node2D

@onready var path_barrel = preload("res://Scenes/Enemies/Pathspawner.tscn")
@onready var path_ketchup = preload("res://Scenes/Enemies/PathspawnerKetchup.tscn")

var lcg_seed = 1

func _ready():
	get_node("../GameStats").wave_start.connect(wave_start)

func wave_start():
	var wave = get_node("../GameStats").wave_current
	var last_wave = get_node("../GameStats").wave_max
	
	var boss_wave = wave == last_wave
	
	var enemy_count = 5 + floor(wave * wave / 1.3)
	for i in enemy_count:
		var type = lcg() % 2
		var kid = null
		if type == 0:
			kid = path_barrel.instantiate()
		else:
			kid = path_ketchup.instantiate()
		kid.get_child(0).get_child(0).health *= 1 + 0.2 * wave
		add_child(kid)
		await get_tree().create_timer(0.5).timeout
	
	if boss_wave:
		var kid = path_barrel.instantiate()
		var kidc = kid.get_child(0).get_child(0)
		kidc.health *= 10
		kidc.scale.x *= 3
		kidc.scale.y *= 3
		kidc.damage *= 3
		kidc.speed /= 2
		add_child(kid)
		enemy_count += 1
	
	get_node("../GameStats").on_wave_spawning_complete(enemy_count)

# Linear Congruential Generator, seed = (a * seed + c) % mod. glibc uses a, c and mod shown below
func lcg() -> int:
	lcg_seed = (25214903917 * lcg_seed + 11) % int(pow(2, 48))
	return lcg_seed
	
