extends Panel

@onready var tower = preload("res://Scenes/Towers/BasicBubbleTower.tscn")

func _on_gui_input(event):
	var temp_tower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:

		add_child(temp_tower)
		temp_tower.global_position = event.global_position
		temp_tower.process_mode = Node.PROCESS_MODE_DISABLED
		print("Left Button Down")

	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
	elif event is InputEventMouseButton and event.button_mask == 0:
		print("1")
		if event.global_position.x >= 1920:
			print("2")
			if get_child_count() > 1:
				print("3")
				get_child(1).queue_free()
		else:
			print("4")
			#check for valid tile:
			if get_child_count() > 1:
				print("5")
				get_child(1).queue_free()
			var path = get_tree().get_root().get_node("LevelTestBench/Towers")
			print("dnais")
			temp_tower.global_position = event.global_position
			path.add_child(temp_tower)
		print("Left Button Up")
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
