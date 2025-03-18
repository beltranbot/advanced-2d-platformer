class_name IdleState
extends Node

@onready var player: Player = get_parent().get_parent()

func _physics_process(delta: float) -> void:
	if player.current_state != "Idle":
		return

	_handle_move_state()
	_handle_jump_state(delta)
	_handle_dash_state()

	_handle_state()


func reset_state() -> void:
	player.jump_count = 0
	player.can_dash = true
	player.animated_sprite.play("Idle")


func _handle_move_state() -> void:
	var is_player_moving = (
		Input.is_action_pressed("move_right") or
		Input.is_action_pressed("move_left")
	)
	if is_player_moving:
		player.change_state("Move")


func _handle_jump_state(delta: float) -> void:
	var is_player_jumping = (
		Input.is_action_just_pressed("jump") and
		player.jump_count < player.max_jumps
	)
	if is_player_jumping:
		player.jump_count += 1
		player.velocity.y = -player.jump_height * delta
		player.change_state("Jump")


func _handle_dash_state() -> void:
	var is_player_dashing = (
		Input.is_action_just_pressed("dash") and
		player.can_dash and
		player.is_on_floor()
	)
	if is_player_dashing:
		player.change_state("Dash")


func _handle_state() -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
