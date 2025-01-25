extends CharacterBody2D


@export var speed = 300
var health = 10

func _physics_process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	var old_rotation = get_parent().rotation
	get_parent().rotation = 0
	
	scale.x = abs(scale.x)
	scale.x *= -1 if old_rotation >= 0 else 1
	
	var dead = get_parent().get_progress_ratio() == 1 or health <= 0
	if dead:
		get_parent().get_parent().queue_free()
