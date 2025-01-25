extends CharacterBody2D

var target
var speed = 200
var pathName = ""
var damage

func _physics_process(delta: float) -> void:
	
	var pathSpawnerNode = get_tree().get_root().get_node("LevelTestBench/PathSpawner")
	
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(1).get_child(0).get_child(0).global_position
	
	velocity = global_position.direction_to(target) * speed
	
	look_at(target)
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		body.health -= damage
		queue_free()
