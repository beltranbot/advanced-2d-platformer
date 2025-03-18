class_name IdleState
extends Node

@onready var player: Node = get_parent().get_parent()

func reset_state() -> void:
	player.jump_count = 0
	player.can_dash = true
	player.animated_sprite.play("Idle")
