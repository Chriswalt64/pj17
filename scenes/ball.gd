extends CharacterBody2D

signal releaseBall
signal lose
var flag : bool
const BOUNDS = Vector2(0, 1280)
var release : bool
@onready var animation = $"../AnimationPlayer"
# Called when the node enters the scene tree for the first time.
func _ready():
	flag = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click") && !release && animation.is_playing():
		emit_signal("releaseBall")
	if release:
		animation.pause()
		velocity += get_gravity() * delta
	
	if is_on_floor() && $"../Win_Lose".text != "You Win!":
		emit_signal("lose")

	move_and_slide()
func _on_release_ball():
	release = true

func _on_node_2d_2_finished():
	animation.play("ball")


func _on_node_2d_cup_entered():
	$"../Win_Lose".text = "You Win!"
	Autoload.progress += 1
	$"../Exit".start()


func _on_exit_timeout():
	Autoload.time += 1
	get_tree().change_scene_to_file("res://scenes/proto_room.tscn")


func _on_lose():
	if !flag:
		flag = true
		$"../Win_Lose".text = "You Lose!"
		$"../Exit".start()


func _on_area_2d_body_entered(body):
	if is_on_floor() && $"../Win_Lose".text != "You Win!":
		emit_signal("lose")
