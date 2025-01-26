extends CharacterBody2D

var target
var speed = 1500
var pathName = ""
var damage

func _ready() -> void:
	var pathSpawnerNode = get_tree().get_root().get_node("LevelTestBench/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(0).get_child(0).get_child(0)
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
		queue_free()
