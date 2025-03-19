extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var change_direction: bool = true


@onready var ray_cliff: RayCast2D = $CliffCheck
@onready var ray_wall: RayCast2D = $WallCheck
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


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
