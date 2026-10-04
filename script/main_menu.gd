extends Control

var music_on = true
var difficulty_picker: Control

const MENU_FONT = preload("res://asset/font/PirataOne-Regular.ttf")

func _ready():
	modulate.a = 0
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.2)

func _on_start_button_pressed() -> void:
	_show_difficulty_picker()


func _show_difficulty_picker() -> void:
	if difficulty_picker == null:
		difficulty_picker = Control.new()
		difficulty_picker.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		difficulty_picker.mouse_filter = Control.MOUSE_FILTER_STOP
		add_child(difficulty_picker)

		var dimmer = ColorRect.new()
		dimmer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		dimmer.color = Color(0, 0, 0, 0.68)
		dimmer.mouse_filter = Control.MOUSE_FILTER_STOP
		difficulty_picker.add_child(dimmer)

		var panel = PanelContainer.new()
		panel.custom_minimum_size = Vector2(400, 280)
		panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
		panel.position = Vector2(-200, -140)
		var panel_style = StyleBoxFlat.new()
		panel_style.bg_color = Color(0.09, 0.07, 0.05, 0.98)
		panel_style.border_width_left = 3
		panel_style.border_width_top = 3
		panel_style.border_width_right = 3
		panel_style.border_width_bottom = 3
		panel_style.border_color = Color(0.55, 0.42, 0.24, 0.9)
		panel_style.set_corner_radius_all(5)
		panel_style.content_margin_left = 28
		panel_style.content_margin_top = 28
		panel_style.content_margin_right = 28
		panel_style.content_margin_bottom = 28
		panel.add_theme_stylebox_override("panel", panel_style)
		difficulty_picker.add_child(panel)

		var options = VBoxContainer.new()
		options.add_theme_constant_override("separation", 18)
		panel.add_child(options)

		var title = Label.new()
		title.text = "CHOOSE DIFFICULTY"
		title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		title.add_theme_font_override("font", MENU_FONT)
		title.add_theme_font_size_override("font_size", 38)
		title.add_theme_color_override("font_color", Color(0.9, 0.82, 0.62))
		options.add_child(title)

		var easy_button = Button.new()
		easy_button.text = "EASY"
		_style_difficulty_button(easy_button)
		easy_button.pressed.connect(_start_game.bind("easy"))
		options.add_child(easy_button)

		var hard_button = Button.new()
		hard_button.text = "HARD"
		_style_difficulty_button(hard_button)
		hard_button.pressed.connect(_start_game.bind("hard"))
		options.add_child(hard_button)


func _style_difficulty_button(button: Button) -> void:
	button.add_theme_font_override("font", MENU_FONT)
	button.add_theme_font_size_override("font_size", 28)
	button.add_theme_color_override("font_color", Color(0.9, 0.82, 0.62))
	button.add_theme_color_override("font_hover_color", Color(0.95, 0.78, 0.4))
	button.add_theme_color_override("font_pressed_color", Color(0.8, 0.3, 0.25))

	var normal = StyleBoxFlat.new()
	normal.bg_color = Color(0.1, 0.08, 0.06, 0.85)
	normal.set_border_width_all(2)
	normal.border_color = Color(0.55, 0.42, 0.24, 0.8)
	normal.set_corner_radius_all(3)
	normal.content_margin_left = 18
	normal.content_margin_top = 8
	normal.content_margin_right = 18
	normal.content_margin_bottom = 8
	button.add_theme_stylebox_override("normal", normal)

	var hover = StyleBoxFlat.new()
	hover.bg_color = Color(0.16, 0.12, 0.08, 0.95)
	hover.set_border_width_all(2)
	hover.border_color = Color(0.85, 0.62, 0.28, 1)
	hover.set_corner_radius_all(3)
	hover.content_margin_left = 18
	hover.content_margin_top = 8
	hover.content_margin_right = 18
	hover.content_margin_bottom = 8
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("focus", hover)

	var pressed = StyleBoxFlat.new()
	pressed.bg_color = Color(0.06, 0.05, 0.04, 1)
	pressed.set_border_width_all(2)
	pressed.border_color = Color(0.702, 0.141, 0.165, 1)
	pressed.set_corner_radius_all(3)
	pressed.content_margin_left = 18
	pressed.content_margin_top = 8
	pressed.content_margin_right = 18
	pressed.content_margin_bottom = 8
	button.add_theme_stylebox_override("pressed", pressed)



func _start_game(difficulty: String) -> void:
	get_tree().root.set_meta("selected_difficulty", difficulty)
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/credits.tscn")


func _on_Endbutton_pressed() -> void:
	get_tree().quit()
