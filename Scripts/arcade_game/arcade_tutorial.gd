extends Node2D

@onready var animPlayer: Node = $Control/AnimationPlayer
@onready var nextAnimTimer: Node = $Control/NextAnimTimer
@onready var titleCardTimer: Node = $Control/TitleCardTimer
@onready var titleCardEndTimer: Node = $Control/TitleCardEndTimer
@onready var titleCard: Node = $Control/TitleBackground

var nextAnim: String


func _ready() -> void:
	titleCardTimer.start()


func next_anim():
	animPlayer.play("controls")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "controls":
		nextAnimTimer.start()


func _on_next_anim_timer_timeout() -> void:
	next_anim()


func _on_title_card_timer_timeout() -> void:
	titleCard.visible = false
	titleCardEndTimer.start()


func _on_title_card_end_timer_timeout() -> void:
	animPlayer.play("controls")


func _on_understood_button_button_up() -> void:
	get_tree().get_root().get_node("ArcadeGame")._start_game()
	queue_free()
