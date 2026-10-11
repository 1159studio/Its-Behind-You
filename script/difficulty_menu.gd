extends Control

func _ready():
	modulate.a = 0

	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.2)

func _on_easy_button_pressed() -> void:
	Difficulty.current = Difficulty.Mode.EASY
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_normal_button_pressed() -> void:
	Difficulty.current = Difficulty.Mode.NORMAL
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_hard_button_pressed() -> void:
	Difficulty.current = Difficulty.Mode.HARD
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
