class_name FallState
extends PlayerState


func _physics_process(delta: float) -> void:
	if player.current_state != PlayerStates.FALL:
		return

	_handle_move_state(delta)
	_handle_jump_state(delta)
	_handle_idle_state()


func reset_state() -> void:
	pass


# override
func _handle_idle_state() -> void:
	if player.is_on_floor():
		player.change_state(PlayerStates.IDLE)
