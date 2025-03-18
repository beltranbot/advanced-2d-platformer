class_name DashState
extends Node


var dash_node: PackedScene = preload("res://Scenes/Player/dash_node.tscn")
var pos: bool

@onready var player: Player = get_parent().get_parent()


func _physics_process(_delta: float) -> void:
	if player.current_state == PlayerStates.DASH:
		var dash: Node = dash_node.instantiate()
		if pos:
			dash.direction = -1
		else:
			dash.direction = 1
		dash.global_position = player.global_position
		player.get_parent().add_child(dash)


func reset_state() -> void:
	pos = player.animated_sprite.flip_h
	player.can_dash = false
	if pos:
		player.velocity.x = 300
	else:
		player.velocity.x = -300

	await get_tree().create_timer(0.2).timeout

	player.change_state(PlayerStates.IDLE)
