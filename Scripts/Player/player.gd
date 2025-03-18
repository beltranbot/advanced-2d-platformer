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

@onready var states = $StateMachine.get_children()
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	change_state("Idle")


func _physics_process(delta: float) -> void:
	_handle_vertical_movement(delta)
	_handle_horizontal_movement()
	move_and_slide()


func change_state(new_state_name: String) -> void:
	current_state = new_state_name
	for state in states:
		if new_state_name == state.name:
			state.reset_node()


func _handle_vertical_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		var target_velocity: float = min(
			velocity.y + (acceleartion * delta),
			max_speed * delta
		)
		velocity.y = lerp(velocity.y, target_velocity, 0.6)
		velocity += get_gravity() * delta


func _handle_horizontal_movement() -> void:
	var movement_direction := Input.get_axis("ui_left", "ui_right")
	if movement_direction < 0:
		animated_sprite.flip_h = false
	elif movement_direction < 0:
		animated_sprite.flip_h = true
