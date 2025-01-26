extends FlowContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_node("../../GameStats").game_over.connect(game_over)
	get_node("ButtonToMainMenu").pressed.connect(to_main_menu)

func game_over():
	visible = true

func to_main_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
