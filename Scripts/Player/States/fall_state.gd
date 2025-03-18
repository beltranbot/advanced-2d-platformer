class_name FallState
extends Node


@onready var player: Player = get_parent().get_parent()

func _physics_process(delta: float) -> void:
	if player.current_state != PlayerStates.FALL:
		return

	_handle_move_state(delta)
	_handle_jump_state(delta)
	_handle_idle_state()


func reset_state() -> void:
	pass


func _handle_jump_state(delta: float) -> void:
	var is_player_jumping = (
		Input.is_action_just_pressed(PlayerActions.JUMP) and
		player.jump_count < player.max_jumps
	)
	if is_player_jumping:
		player.jump_count += 1
		player.velocity.y = (-player.jump_height) * delta
		player.change_state(PlayerActions.JUMP)


func _handle_idle_state() -> void:
	if player.is_on_floor():
		player.jump_count = 0
		player.can_dash = true
		player.change_state(PlayerStates.IDLE)


func _handle_move_state(delta: float) -> void:
	_handle_moving_right(delta)
	_handle_moving_left(delta)


func _handle_moving_right(delta: float) -> void:
	if not Input.is_action_pressed(PlayerActions.MOVE_RIGHT):
		return

	var target_velocity: float = min(
		player.velocity.x + (player.acceleartion * delta),
		player.max_speed * delta
	)
	player.velocity.x = lerp(player.velocity.x, target_velocity, player.weight)


func _handle_moving_left(delta: float) -> void:
	if not Input.is_action_pressed(PlayerActions.MOVE_LEFT):
		return

	var target_velocity: float = min(
		player.velocity.x - (player.acceleartion * delta),
		- player.max_speed * delta
	)
	player.velocity.x = lerp(player.velocity.x, target_velocity, player.weight)
