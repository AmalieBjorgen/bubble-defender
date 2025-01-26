extends FlowContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_node("../../GameStats").game_win.connect(game_win)
	get_node("ButtonToContinue").pressed.connect(continue_endless)

func game_win():
	visible = true

func continue_endless():
	visible = false
	get_node("../../GameStats").on_game_continue_after_win()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
