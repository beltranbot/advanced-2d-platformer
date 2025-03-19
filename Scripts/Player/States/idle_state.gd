class_name IdleState
extends PlayerState


func _physics_process(delta: float) -> void:
	if player.current_state != PlayerStates.IDLE:
		return

	_handle_move_state(delta)
	_handle_jump_state(delta)
	_handle_dash_state()
	_handle_idle_state()


func reset_state() -> void:
	player.jump_count = 0
	player.can_dash = true
	player.animated_sprite.play(PlayerAnimations.IDLE)


# override
func _handle_move_state(_delta: float) -> void:
	var player_is_moving = (
		Input.is_action_pressed(PlayerActions.MOVE_RIGHT) or
		Input.is_action_pressed(PlayerActions.MOVE_LEFT)
	)
	if player_is_moving:
		player.change_state(PlayerStates.MOVE)


# override
func _handle_idle_state() -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
