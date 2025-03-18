class_name IdleState
extends Node


@onready var player: Player = get_parent().get_parent()

func _physics_process(delta: float) -> void:
	if player.current_state != PlayerStates.IDLE:
		return

	_handle_move_state()
	_handle_jump_state(delta)
	_handle_dash_state()

	_handle_state()


func reset_state() -> void:
	player.jump_count = 0
	player.can_dash = true
	player.animated_sprite.play(PlayerAnimations.IDLE)


func _handle_move_state() -> void:
	var player_is_moving = (
		Input.is_action_pressed(PlayerActions.MOVE_RIGHT) or
		Input.is_action_pressed(PlayerActions.MOVE_LEFT)
	)
	if player_is_moving:
		player.change_state(PlayerStates.MOVE)


func _handle_jump_state(delta: float) -> void:
	var player_is_jumping = (
		Input.is_action_just_pressed(PlayerActions.JUMP) and
		player.jump_count < player.max_jumps
	)
	if player_is_jumping:
		player.jump_count += 1
		player.velocity.y = -player.jump_height * delta
		player.change_state(PlayerActions.JUMP)


func _handle_dash_state() -> void:
	var player_is_dashing = (
		Input.is_action_just_pressed(PlayerActions.DASH) and
		player.can_dash and
		player.is_on_floor()
	)
	if player_is_dashing:
		player.change_state(PlayerStates.DASH)


func _handle_state() -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
