extends ColorRect

var canStartGame : bool


# Called when the node enters the scene tree for the first time.
func _ready():
	$Interact.visible = false
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") && canStartGame:
		get_tree().change_scene_to_file("res://item_find.tscn")



func _on_area_2d_body_entered(body):
	$Interact.visible = true
	canStartGame = true


func _on_area_2d_body_exited(body):
	$Interact.visible = false
	canStartGame = false
