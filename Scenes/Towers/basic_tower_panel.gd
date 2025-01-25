extends Panel

@onready var tower = preload("res://Scenes/Towers/BasicBubbleTower.tscn")

func _on_gui_input(event):
	var temp_tower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:

		add_child(temp_tower)
		temp_tower.global_position = event.global_position
		temp_tower.process_mode = Node.PROCESS_MODE_DISABLED

	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
	elif event is InputEventMouseButton and event.button_mask == 0:
		if event.global_position.x >= 1920:
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:
			#check for valid tile:
			if get_child_count() > 1:
				get_child(1).queue_free()
			var path = get_tree().get_root().get_node("LevelTestBench/Towers")
			temp_tower.global_position = event.global_position
			path.add_child(temp_tower)
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
