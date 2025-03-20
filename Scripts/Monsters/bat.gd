extends CharacterBody2D


const SPEED = 050.0

var change_direction: bool = false


@onready var ray_floor: RayCast2D = $FloorCheck
@onready var death_sound: AudioStreamPlayer2D = $Death


func _physics_process(_delta: float) -> void:
	_floor_check()
	_handle_change_direction()

	move_and_slide()


func _floor_check():
	if ray_floor.is_colliding():
		_toggle_change_direction()
		ray_floor.target_position.y *= -1

func _handle_change_direction():
	velocity.y = (-SPEED) if change_direction else SPEED


func _toggle_change_direction():
	change_direction = not change_direction


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		death()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player = body as Player
		if player.current_state == PlayerStates.DASH:
			death()
			return

		Game.health -= 1
		body.hit_sound.play()


func _on_death_finished() -> void:
	queue_free()


func death():
	hide()
	$CollisionShape2D.call_deferred("set_disabled", true)
	death_sound.play()
