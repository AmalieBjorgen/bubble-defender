extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("../../../../GameStats").money_changed.connect(money_changed)
	money_changed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func money_changed():
	var s = get_node("../../../../GameStats")
	text = str(s.money)
