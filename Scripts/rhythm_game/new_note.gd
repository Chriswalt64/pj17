extends Area2D

@onready var rhythmGame: Node = get_tree().get_root().get_node("RhythmGame")


func _ready() -> void:
	global_position = get_viewport_rect().size / 2
	#rhythmGame.canBeat = false
	pass


func _process(_delta: float) -> void:
	pass


func _is_it(what):
	return "Note" == what


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_note":
		rhythmGame.progressCounter += 1
		rhythmGame.result = "Perfect"
		rhythmGame.check_progress()
		queue_free()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("space") && rhythmGame.canBeat:
		queue_free()
	pass
