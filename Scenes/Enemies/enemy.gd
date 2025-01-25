extends CharacterBody2D


@export var speed = 200
var health = 10


func _physics_process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	
	var dead = get_parent().get_progress_ratio() == 1 or health <= 0
	if dead:
		get_parent().get_parent().queue_free()
