extends Area2D


@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		sprite.hide()
		audio.play()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
