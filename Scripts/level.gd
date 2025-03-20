extends Node2D



func _on_death_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$GameOver.game_over()
