extends ColorRect

var canStartGame : bool
signal minigameStart


# Called when the node enters the scene tree for the first time.
func _ready():
	$Interact.visible = false
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") && canStartGame:
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		Dialogic.start('test')
		get_viewport().set_input_as_handled()
		



func _on_area_2d_body_entered(body):
	$Interact.visible = true
	canStartGame = true


func _on_area_2d_body_exited(body):
	$Interact.visible = false
	canStartGame = false
	
func _on_timeline_ended():
	emit_signal("minigameStart")
	get_tree().change_scene_to_file("res://scenes/rhythm_game.tscn")
