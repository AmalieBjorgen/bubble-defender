extends CharacterBody2D

var target
var speed = 1500
var pathName = ""
var damage

func _ready() -> void:
	var pathSpawnerNode = get_tree().get_root().get_node("LevelTestBench/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			if pathSpawnerNode.get_child(1) == null or pathSpawnerNode.get_child(1).get_child(0) == null: continue # temp bugfix
			target = pathSpawnerNode.get_child(1).get_child(0).get_child(0)
			if target != null:
				break

func _physics_process(delta: float) -> void:
	if !is_instance_valid(target):
		queue_free()
		return
	
	velocity = global_position.direction_to(target.global_position) * speed
	look_at(target.global_position)
	move_and_slide()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		body.health -= damage
		body.speed = body.speed/2
		if body.speed <= 200:
			body.speed = 200
		queue_free()
		for i in range(damage):
			damage -= 1
			body.health -= damage
			await get_tree().create_timer(1).timeout
