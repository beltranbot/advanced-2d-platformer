class_name JumpState
extends PlayerState


func _physics_process(delta: float) -> void:
	if player.current_state != PlayerStates.JUMP:
		return

	_handle_move_state(delta)
	_handle_jump_state(delta)
	_handle_fall_state()


func reset_state() -> void:
	player.get_node("Jump").play()
