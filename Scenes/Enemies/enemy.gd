extends CharacterBody2D


@export var speed = 450
@export var max_health = 10
var health = max_health
@export var damage = 10
@export var money_reward = 10

@export var frame1path = ""
@export var frame2path = ""
var accumulated_time = 0
var frame1texture = null
var frame2texture = null

func _ready():
	frame1texture = load(frame1path)
	frame2texture = load(frame2path)

func _process(delta: float) -> void:
	accumulated_time += delta
	while accumulated_time >= 1: accumulated_time -= 1 # modulo doesn't work...
	if int(floor(accumulated_time * 6)) % 2 == 0:
		get_node("Sprite2D").texture = frame1texture
	else:
		get_node("Sprite2D").texture = frame2texture

func _physics_process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	var old_rotation = get_parent().rotation
	get_parent().rotation = 0
	
	scale.x = abs(scale.x)
	scale.x *= -1 if old_rotation >= 0 else 1
	
	var dead = health <= 0
	var in_pool = get_parent().get_progress_ratio() >= 0.99
	
	var s = get_node("../../../../GameStats")
	if in_pool: s.deal_damage_to_pool(damage)
	if dead: s.gain_money(money_reward)
	
	if in_pool or dead:
		get_parent().get_parent().queue_free()
		s.on_enemy_exit_scene()

func get_hp():
	return health
