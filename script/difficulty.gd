extends Node

# Global difficulty selection. Set from the difficulty menu and read by the
# game manager when a run starts. Registered as an autoload singleton, so it
# survives the scene change from the menu into the game.

enum Mode { EASY, NORMAL, HARD }

var current : Mode = Mode.NORMAL

# When true, the start-of-run tutorial is skipped. Toggled from the main menu
# (and the tutorial screen itself) and saved to disk, so the choice survives
# both scene reloads and quitting the game entirely.
var skip_tutorial : bool = false

const SETTINGS_PATH := "user://settings.cfg"

func _ready():
	_load_settings()

func set_skip_tutorial(value: bool) -> void:
	skip_tutorial = value
	_save_settings()

func _load_settings() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SETTINGS_PATH) == OK:
		skip_tutorial = cfg.get_value("tutorial", "skip", false)

func _save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("tutorial", "skip", skip_tutorial)
	cfg.save(SETTINGS_PATH)
