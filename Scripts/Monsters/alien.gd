extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var change_direction: bool = true


@onready var ray_wallcliff: RayCast2D = $CliffCheck
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not ray_wallcliff.is_colliding():
		change_direction = !change_direction
		ray_wallcliff.position.x *= -1

	if change_direction:
		velocity.x = -SPEED
		sprite.flip_h = false
	else:
		velocity.x = SPEED
		sprite.flip_h = true

	move_and_slide()
