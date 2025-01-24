extends PathFollow2D

var SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	var max_progress = 1000
	if progress_ratio != 0:
		max_progress = progress / progress_ratio
	
	var gain = SPEED * delta
	
	if progress + gain > max_progress:
		progress = max_progress
	else:
		progress += gain
	
