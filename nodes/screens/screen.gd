extends MarginContainer
class_name GameScreen

signal did_prepare_for_hiding
signal did_hide_with_transition
signal did_prepare_for_showing
signal did_show_with_transition

onready var _transitions_animator := $Transitions/Animator as AnimationPlayer

func prepare_for_hiding(next_screen: int) -> void:
	emit_signal("did_prepare_for_hiding")

func hide_with_transition(next_screen: int) -> void:
	_transitions_animator.play("show")
	yield(_transitions_animator, "animation_finished")
	emit_signal("did_hide_with_transition")

func prepare_for_showing(previous_screen: int) -> void:
	emit_signal("did_prepare_for_showing")

func show_with_transition(previous_screen: int) -> void:
	# this strange set of method calls sets the current animation
	# to the beginning of Cover's hide animation, without playing it
	# so that Cover is covering everything
	_transitions_animator.play("hide")
	_transitions_animator.stop()
	_transitions_animator.seek(0.0, true)

	# this is just to demonstrate a longer loading time
	# ...and should be removed once you're happy with the transition mechanics
	# ...or replaced with expensive loading
	yield(get_tree().create_timer(2.0), "timeout")

	_transitions_animator.play("hide")
	yield(_transitions_animator, "animation_finished")
	emit_signal("did_show_with_transition")
