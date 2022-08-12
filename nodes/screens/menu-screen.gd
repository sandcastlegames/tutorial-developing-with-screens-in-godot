extends GameScreen

func _on_PlayButton_pressed() -> void:
	Screens.change_screen(Constants.screens.play)

func _on_SettingsButton_pressed() -> void:
	Screens.change_screen(Constants.screens.settings)

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
