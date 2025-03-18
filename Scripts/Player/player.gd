extends CharacterBody2D


var max_speed: int = 8000
var acceleartion: int = 1000
var jump_height: int = 15000
var direction: int = 0

var friction: float = 0.22
var weight: float = 0.35

#### state ####
var current_state: String = ""
var can_dash: bool = true
var max_jumps: int = 3
var jump_count: int = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		var target_velocity: float = min(
			velocity.y + (acceleartion * delta),
			max_speed * delta
		)
		velocity.y = lerp(velocity.y, target_velocity, 0.6)
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var movement_direction := Input.get_axis("ui_left", "ui_right")
	if movement_direction < 0:
		animated_sprite.flip_h = false
	elif movement_direction < 0:
		animated_sprite.flip_h = true

	move_and_slide()
