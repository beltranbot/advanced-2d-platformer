class_name MoveState
extends PlayerState


func _physics_process(delta: float) -> void:
	if player.current_state != PlayerStates.MOVE:
		return

	_handle_idle_state()
	_handle_jump_state(delta)
	_handle_dash_state()
	_handle_move_state(delta)


func reset_state() -> void:
	player.animated_sprite.play(PlayerAnimations.MOVE)
