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
