extends Node2D


@onready var path = preload("res://Scenes/Enemies/Pathspawner.tscn")


func _on_timer_timeout() -> void:
	add_child(path.instantiate())
