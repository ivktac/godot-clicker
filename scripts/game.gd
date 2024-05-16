extends Node2D

@onready var countdown_timer_label = $HUD/MarginContainer/VBoxContainer/CountdownTimer
@onready var timer = $Timer

@onready var score_label = $HUD/MarginContainer/VBoxContainer/Score
@onready var vegetables_label = $HUD/MarginContainer/VBoxContainer/Vegetables
@onready var fruits_label = $HUD/MarginContainer/VBoxContainer/Fruits


@onready var fruit = preload("res://nodes/fruit.tscn")
@onready var vegetable = preload("res://nodes/vegetable.tscn")

@onready var gen = $Generation

func _ready():
	reset_globals()
	
	gen.start()
	timer.start()

func _process(_delta):
	self.update_hud()
	
	if !timer.is_stopped():
		update_timer()
	else:
		game_over()


func _on_generation_timeout():
	randomize()
	
	var plant = gen_plant()
	plant.position = Vector2(randi_range(200, 1100), randi_range(200, 500))
	self.add_child(plant)
	
	gen.wait_time = randf_range(0, 0.5) + randf_range(0, 0.5)

func gen_plant() -> Node2D:
	var plants = [fruit, vegetable]
	var kinds = plants[randi() % plants.size()]
	return kinds.instantiate()

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func update_hud():
	countdown_timer_label.text = "%02d:%02d" % time_left_to_live()
	score_label.text = "SCORE: %d" % Globals.score
	vegetables_label.text = "Vegetables: %d" % Globals.clicked_vegetables
	fruits_label.text = "Fruits: %d" % Globals.clicked_fruits

func reset_globals():
	Globals.score = 0
	Globals.clicked_fruits = 0
	Globals.clicked_vegetables = 0
	Globals.duration = 0
	Globals.is_clicked = false
	Globals.is_game_over = false

func update_timer():
	if Globals.is_clicked:
		if (timer.time_left + Globals.duration > 0):
			timer.start(timer.time_left + Globals.duration)
		Globals.is_clicked = false
		
func game_over():
	Globals.is_game_over = true
	self.get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
