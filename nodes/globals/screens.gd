extends Node

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

	var new_screen_node : GameScreen = Constants.screen_scenes[new_screen].instance()
	load_new_screen(new_screen_node, new_screen)

	is_changing_screen = false

func load_new_screen(new_screen_node: GameScreen, new_screen: int):
	current_screen_node.call_deferred("prepare_for_hiding", new_screen)
	yield(current_screen_node, "did_prepare_for_hiding")

	root.add_child(new_screen_node)
	new_screen_node.visible = false

	new_screen_node.call_deferred("prepare_for_showing", current_screen)
	yield(new_screen_node, "did_prepare_for_showing")

	current_screen_node.call_deferred("hide_with_transition", new_screen)
	yield(current_screen_node, "did_hide_with_transition")

	current_screen_node.queue_free()
	new_screen_node.visible = true

	new_screen_node.call_deferred("show_with_transition", current_screen)
	yield(new_screen_node, "did_show_with_transition")

	current_screen = new_screen
	current_screen_node = new_screen_node

	OS.hide_virtual_keyboard()
