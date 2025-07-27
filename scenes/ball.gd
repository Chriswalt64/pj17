extends CharacterBody2D

signal releaseBall
const BOUNDS = Vector2(0, 1280)
var release : bool
@onready var animation = $"../AnimationPlayer"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click") && !release && animation.is_playing():
		emit_signal("releaseBall")
	if release:
		animation.pause()
		velocity += get_gravity() * delta

	move_and_slide()
func _on_release_ball():
	release = true

func _on_node_2d_2_finished():
	animation.play("ball")


func _on_node_2d_cup_entered():
	$"../Win_Lose".text = "You Win!"
	$"../Exit".start()


func _on_exit_timeout():
	get_tree().change_scene_to_file("res://scenes/proto_room.tscn")
