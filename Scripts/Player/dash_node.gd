extends AnimatedSprite2D


var direction


func _physics_process(_delta: float) -> void:
	if direction < 0:
		flip_h = true
	else:
		flip_h = false

	# move the node
	position.x -= direction

	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)
	tween.tween_callback(self.queue_free)
