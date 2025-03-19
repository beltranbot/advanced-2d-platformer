extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var change_direction: bool = true


@onready var ray_cliff: RayCast2D = $CliffCheck
@onready var ray_wall: RayCast2D = $WallCheck
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound: AudioStreamPlayer2D = $Death


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	_cliff_check()
	_wall_check()
	_handle_change_direction()

	move_and_slide()


func _cliff_check():
	if not ray_cliff.is_colliding():
		_toggle_change_direction()
		ray_cliff.position.x *= -1


func _wall_check():
	if ray_wall.is_colliding():
		_toggle_change_direction()
		ray_wall.position.x *= -1
		ray_wall.rotation *= -1


func _handle_change_direction():
	if change_direction:
		velocity.x = - SPEED
		sprite.flip_h = false
	else:
		velocity.x = SPEED
		sprite.flip_h = true


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
