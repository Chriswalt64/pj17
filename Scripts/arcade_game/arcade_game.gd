extends Node2D

@onready var shipLoad: Resource = load("res://scenes/arcade_game/ship.tscn")
@onready var enemyPhase1Animation: Node = $EnemyPhase1/AnimationPlayer
@onready var scoreLabel: Node = $ScoreLabel
@onready var hiLabel: Node = $HiLabel
@onready var respawnTimer: Node = $RespawnTimer

var phase: int
var enemyBulletSpawn: Vector2
var score: int = 0

func _ready() -> void:
	phase = 0
	enemyPhase1Animation.play("enter_screen")
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	phase = 1
	pass


func _update_score():
	scoreLabel.text = "SCORE: " + str(score)
	if score == 700:
		hiLabel.text = "HI: " + str(score)
	pass


func _on_respawn_timer_timeout() -> void:
	var ship = shipLoad.instantiate()
	get_tree().get_root().get_node("ArcadeGame").add_child(ship)
	pass
