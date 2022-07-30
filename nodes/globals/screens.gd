extends Node

export var menu_screen_scene : PackedScene
export var settings_screen_scene : PackedScene
export var play_screen_scene : PackedScene

enum screens {
	menu,
	settings,
	play,
}

onready var screen_scenes := {
	screens.menu: menu_screen_scene,
	screens.settings: settings_screen_scene,
	screens.play: play_screen_scene,
}

var root = null
var current_screen: int
var current_screen_node: GameScreen
var is_changing_screen := false

func _ready() -> void:
	root = get_tree().get_root()
	current_screen_node = root.get_child(root.get_child_count() - 1)

func change_screen(new_screen: int) -> void:
	if is_changing_screen:
		return

	is_changing_screen = true

	var new_screen_node : GameScreen = screen_scenes[new_screen].instance()
	load_new_screen(new_screen_node, new_screen)

func load_new_screen(new_screen_node: GameScreen, new_screen: int):
	current_screen_node.queue_free()
	root.add_child(new_screen_node)

	current_screen = new_screen
	current_screen_node = new_screen_node

	OS.hide_virtual_keyboard()

	is_changing_screen = false
