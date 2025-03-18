class_name Player
extends CharacterBody2D


var max_speed: int = 8000
var acceleration: int = 1000
var jump_height: int = 15000
var direction: int = 0

var friction: float = 0.22
var weight: float = 0.35


#### state ####
var current_state: String = ""
var can_dash: bool = true
var max_jumps: int = 3
var jump_count: int = 0

@onready var states = $StateMachine.get_children()
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	change_state(PlayerStates.IDLE)


func _physics_process(delta: float) -> void:
	_handle_vertical_movement(delta)
	_handle_horizontal_movement()
	move_and_slide()


func change_state(new_state_name: String) -> void:
	current_state = new_state_name
	for state in states:
		if new_state_name == state.name:
			state.reset_state()


func _handle_vertical_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		var target_velocity: float = min(
			velocity.y + acceleration * delta,
			max_speed * delta
		)
		velocity.y = lerp(velocity.y, target_velocity, 0.6)

func _handle_horizontal_movement() -> void:
	direction = Input.get_axis(
		PlayerActions.MOVE_LEFT,
		PlayerActions.MOVE_RIGHT
	) as int
	if direction < 0:
		animated_sprite.flip_h = false
	elif direction > 0:
		animated_sprite.flip_h = true
