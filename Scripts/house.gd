extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("house_idle")
	if Autoload.rhythmGameComplete:
		$RhythmPerson.queue_free()
		$Dancers.queue_free()
	if Autoload.arcadeGameComplete:
		$RhythemPerson.queue_free()
	if Autoload.pongGameComplete:
		$PongPerson.queue_free()
	if Autoload.itemGameComplete:
		$ItemFindPerson.queue_free()
