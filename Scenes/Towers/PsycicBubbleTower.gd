extends StaticBody2D

var Bullet = preload("res://Scenes/Towers/PsycicBullet.tscn")
var bulletDamage = 3
var pathName
var currentTargets = []
var currentTarget 
var frames = 0

func _process(delta: float) -> void:
	if is_instance_valid(currentTarget):
		self.look_at(currentTarget.global_position)
		rotation += PI # Rotate around 180 deg
		while rotation < 0: rotation += 2 * PI
		while rotation >= 2 * PI: rotation -= 2 * PI # modulo 2 * PI doesn't work...
		
		var sprite = get_parent().get_child(0)
		sprite.scale.x = abs(sprite.scale.x)
		var flip = not (rotation >= PI / 2 and rotation < PI * 3 / 2)
		if flip:
			sprite.scale.x *= -1
			sprite.rotation = rotation - PI
		else:
			sprite.rotation = rotation
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()

func _physics_process(delta: float) -> void:
	frames += 1
	if currentTarget != null and frames%60 == 0:
		pathName = currentTarget.get_parent().name
		var tempBullet = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.damage = bulletDamage
		get_node("BulletContainer").add_child(tempBullet)
		tempBullet.global_position = $Aim.global_position
		
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
	
