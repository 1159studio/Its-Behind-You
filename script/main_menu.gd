extends Control

var music_on = true

var tutorial_toggle : Button

func _ready():
	modulate.a = 0

	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.2)

	_build_tutorial_toggle()

# A "TUTORIAL: ON / OFF" button slotted into the existing menu stack. It mirrors
# the global Difficulty.skip_tutorial setting (persisted to disk), so turning it
# off here keeps the start-of-run tutorial from showing.
func _build_tutorial_toggle():
	var vb = $VBoxContainer
	var ref_btn = vb.get_node("StartButton")   # copy the menu's button look

	tutorial_toggle = Button.new()
	tutorial_toggle.focus_mode = Control.FOCUS_NONE
	tutorial_toggle.add_theme_font_override("font", ref_btn.get_theme_font("font"))
	tutorial_toggle.add_theme_font_size_override("font_size", 24)
	tutorial_toggle.add_theme_color_override("font_color", Color(0.9, 0.82, 0.62))
	tutorial_toggle.add_theme_color_override("font_hover_color", Color(0.95, 0.78, 0.4))
	tutorial_toggle.add_theme_color_override("font_pressed_color", Color(0.8, 0.3, 0.25))
	for s in ["normal", "hover", "pressed", "focus"]:
		var sb = ref_btn.get_theme_stylebox(s)
		if sb:
			tutorial_toggle.add_theme_stylebox_override(s, sb)

	_update_tutorial_toggle_text()
	tutorial_toggle.pressed.connect(_on_tutorial_toggle_pressed)

	vb.add_child(tutorial_toggle)
	vb.move_child(tutorial_toggle, 2)   # just below START

func _update_tutorial_toggle_text():
	tutorial_toggle.text = "TUTORIAL: OFF" if Difficulty.skip_tutorial else "TUTORIAL: ON"

func _on_tutorial_toggle_pressed() -> void:
	Difficulty.set_skip_tutorial(not Difficulty.skip_tutorial)
	_update_tutorial_toggle_text()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/difficulty_menu.tscn")


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/credits.tscn")


func _on_Endbutton_pressed() -> void:
	get_tree().quit()
