extends Node2D

signal pool_health_changed
signal money_changed
signal wave_timer_changed
signal wave_start
signal game_over
signal game_win

@export var pool_health_max = 100
var pool_health = pool_health_max
@export var money = 100

@export var WAVE_TIMER_BETWEEN_WAVES = 30
var wave_timer = WAVE_TIMER_BETWEEN_WAVES
var wave_current = 0
var wave_max = 7
var has_game_overed = false

var accumulated_time = 0

var wave_spawning = false
var wave_enemies_done = 0 # number of enemies exited the scene (dead or entered pool)
var wave_enemies_spawned = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if wave_timer == 0 or has_game_overed: return

	accumulated_time += delta
	if accumulated_time >= 1: # check one second at a time to virtualize pausing if user onfocuses app
		wave_timer -= 1
		wave_timer_changed.emit()
		if wave_timer == 0: start_wave()
		accumulated_time = 0

func _input(ev):
	if Input.is_key_pressed(KEY_G):
		wave_preemptive_start()

# Called when user clicks button to start wave now
func wave_preemptive_start():
	if wave_timer > 5:
		wave_timer = 5
		wave_timer_changed.emit()

# Is called when all enemies of a wave are gone
func wave_over():
	if wave_current == wave_max:
		game_win.emit()
	else:
		wave_timer = WAVE_TIMER_BETWEEN_WAVES

# Called when player clicks "continue endless mode" in the "Victory!" dialogue box
func on_game_continue_after_win():
	wave_timer = WAVE_TIMER_BETWEEN_WAVES

func on_enemy_exit_scene():
	wave_enemies_done += 1
	if not wave_spawning and wave_enemies_done >= wave_enemies_spawned: wave_over()

# Called by spawner when spawning is complete
func on_wave_spawning_complete(enemies_spawned: int) -> void:
	wave_enemies_spawned = enemies_spawned
	wave_spawning = false

func deal_damage_to_pool(amount: int) -> void:
	pool_health -= amount
	pool_health_changed.emit()
	if pool_health <= 0:
		has_game_overed = true
		game_over.emit()

func gain_money(amount: int):
	money += amount
	money_changed.emit()

func lose_money(amount: int):
	money -= amount
	money_changed.emit()

func start_wave():
	wave_spawning = true
	wave_enemies_done = 0
	wave_current += 1
	wave_start.emit()
