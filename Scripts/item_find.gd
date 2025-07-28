extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Node2D2/AnimationPlayer.play("countdown")
	$Node2D.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$win_lose.text = "You Lose!"
	$Timer.stop()
	$exit.start()


func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Timer.stop()
	$win_lose.text = "You Win!"
	Autoload.progress += 1
	$exit.start()
	


func _on_node_2d_2_finished():
	$Node2D2.visible = false
	$Timer.start()
	$Node2D.visible = true



func _on_exit_timeout():
	Autoload.time += 1
	get_tree().change_scene_to_file("res://scenes/proto_room.tscn")
