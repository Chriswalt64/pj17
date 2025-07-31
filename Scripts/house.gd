extends Node2D
var gamefinish: int
func _ready() -> void:
	$AnimationPlayer.play("house_idle")
	if Autoload.rhythmGameComplete:
		$RhythmPerson.queue_free()
		$Dancers.queue_free()
		gamefinish += 1
	if Autoload.arcadeGameComplete:
		gamefinish += 1
		$ArcadePerson.queue_free()
	if Autoload.pongGameComplete:
		gamefinish += 1
		$PongPerson.queue_free()
	if Autoload.itemGameComplete:
		gamefinish += 1
		$ItemFindPerson.queue_free()
	if gamefinish == 4:
		$AudioStreamPlayer2D.stop()
		Dialogic.start('end')
		get_viewport().set_input_as_handled()
		
