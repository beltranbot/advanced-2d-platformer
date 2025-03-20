extends Area2D


@export_file("*.tscn") var scene_path


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("change_scene_to_file", scene_path)
