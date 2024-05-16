class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var start_game = preload("res://scenes/game.tscn") as PackedScene

@onready var menu_title = $MarginContainer/VBoxContainer/MenuTitle
@onready var score_status_label = $MarginContainer/VBoxContainer/ScoreStatus

func _ready():
	if Globals.is_game_over:
		menu_title.text = "Game Over"
		score_status_label.text = "Score: %d" % Globals.score
	
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)


func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_game)
	

func on_exit_pressed() -> void:
	get_tree().quit()
