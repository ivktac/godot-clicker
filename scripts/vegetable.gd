extends Sprite2D

var frames = texture.get_width() / region_rect.size.x
var delay = 0

func _ready():
	var random_index = randi_range(0, frames - 1)
	region_rect.position.x = random_index * region_rect.size.x

func _process(delta):
	delay += delta
	if delay > 5:
		delay = 0
		queue_free()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			Globals.score -= 1
			Globals.clicked_vegetables += 1
			Globals.is_clicked = true
			Globals.duration = -10
			queue_free()

