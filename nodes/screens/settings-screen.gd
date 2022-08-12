extends GameScreen

func _on_BackButton_pressed() -> void:
	Screens.change_screen(Constants.screens.menu)
