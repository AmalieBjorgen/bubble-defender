extends CharacterBody2D


@export var speed = 750
@export var health = 10
@export var damage = 10
@export var money_reward = 10

func _physics_process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	var old_rotation = get_parent().rotation
	get_parent().rotation = 0
	
	scale.x = abs(scale.x)
	scale.x *= -1 if old_rotation >= 0 else 1
	
	var dead = health <= 0
	var in_pool = get_parent().get_progress_ratio() >= 0.99
	
	var s = get_node("../../../../GameStats")
	if in_pool: s.deal_damage_to_pool(damage)
	if dead: s.gain_money(money_reward)
	
	if in_pool or dead:
		get_parent().get_parent().queue_free()
		s.on_enemy_exit_scene()
