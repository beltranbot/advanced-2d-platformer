extends Node

@export var first_level : PackedScene = preload("res://Scenes/Levels/level_01.tscn")


func _on_play_pressed() -> void:
	get_tree().call_deferred("change_scene_to_packed", first_level)
