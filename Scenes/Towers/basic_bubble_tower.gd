extends StaticBody2D

var Bullet = preload("res://Scenes/Towers/bubble_bullet.tscn")
var bulletDamage = 5
var pathName
var currentTargets = []
var currentTarget 


func _on_tower_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		var tempArray = []
		currentTargets = get_node("Tower").get_overlapping_bodies()
		
		for target in currentTargets:
			if "Enemy" in target.name:
				tempArray.append(target)
		
		var target = null
		
		for i in tempArray:
			if target == null:
				target = i.get_node("../")
			else:
				if i.get_parent().get_progress() > target.get_progress():
					target = i.get_node("../")
					
		currentTarget = target
		pathName = currentTarget.get_parent().name
		
		var tempBullet = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.damage = bulletDamage
		get_node("BulletContainer").add_child(tempBullet)
		tempBullet.global_position = $Aim.global_position
		

func _on_tower_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
