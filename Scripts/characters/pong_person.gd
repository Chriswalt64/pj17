extends Area2D

@onready var player: Node = $"../Player"

var canStartGame : bool

signal minigameStart


func _ready():
	$Interact.visible = false


func _process(delta):
	if Input.is_action_just_pressed("interact") && canStartGame:
		Dialogic.timeline_ended.connect(_on_timeline_ended)
		Dialogic.start('Pong')
		get_viewport().set_input_as_handled()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_it_is") && body._it_is("player"):
		$Interact.visible = true
		canStartGame = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("_it_is") && body._it_is("player"):
		$Interact.visible = false
		canStartGame = false


func _on_timeline_ended():
	emit_signal("minigameStart")
	get_tree().change_scene_to_file("res://scenes/pong.tscn")
