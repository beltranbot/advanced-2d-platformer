extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	get_tree().paused = false


func game_over() -> void:
	show()
	get_tree().paused = true


func _on_retry_button_pressed() -> void:
	Game.gold = 0
	Game.health = Game.max_health
	hide()
	$GameOverSound.play()
	get_tree().reload_current_scene()
