extends CanvasLayer


@onready var gold_label: Label = $Gold
@onready var heart_container: HBoxContainer = $HeartContainer
@onready var heart_scene: PackedScene = preload("res://Scenes/Player/heart.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(Game.health):
		var heart: Node = heart_scene.instantiate()
		heart_container.add_child(heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	gold_label.text = "Gold: " + str(Game.gold)

	if Game.health >= 1:
		if heart_container.get_child_count() > Game.health:
			heart_container.get_child(heart_container.get_child_count() - 1).queue_free()
	else:
		# go to game over
		$"../GameOver".game_over()
