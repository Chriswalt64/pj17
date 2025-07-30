extends Node2D

@onready var enemyPhase1: Node = $EnemyPhase1
@onready var enemyPhase1Animation: Node = $EnemyPhase1/AnimationPlayer
@onready var starsAnimPlayer: Node = $ScreenCenter/AnimationPlayer
@onready var scoreLabel: Node = $ScoreLabel
@onready var hiLabel: Node = $HiLabel
@onready var gameEndLabel: Node = $GameEndLabel
@onready var respawnTimer: Node = $RespawnTimer
@onready var gameCloseTimer: Node = $GameCloseTimer
@onready var lifeDisplay: Node = $Lives
@onready var arcadeTutorialLoad: Resource = load("res://scenes/arcade_game/arcade_tutorial.tscn")
@onready var countdownLoad: Resource = load("res://scenes/countdown.tscn")
@onready var shipLoad: Resource = load("res://scenes/arcade_game/ship.tscn")

var tutorial: bool
var phase: int
var enemyBulletSpawn: Vector2
var score: int = 0
var lives: int = 3
var lostLife: int = 2

func _ready() -> void:
	var arcadeTutorial: Node = arcadeTutorialLoad.instantiate()
	get_tree().get_root().get_node("ArcadeGame").add_child(arcadeTutorial)
	phase = 0
	tutorial = true
	pass


func _start_game():
	var countdown: Node = countdownLoad.instantiate()
	get_tree().get_root().get_node("ArcadeGame").add_child(countdown)
	var childCount: int = get_tree().get_root().get_node("ArcadeGame").get_child_count()
	var countdownNode: Node = get_tree().get_root().get_node("ArcadeGame").get_child(childCount - 1)
	countdownNode.position = Vector2(1280/2 - 29, (720/2) - 72)
	starsAnimPlayer.play("stars_move")
	enemyPhase1Animation.play("enter_screen")
	tutorial = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "enter_screen":
		phase = 1 #was going to add in multiple phases, but decided to save time instead
	pass


func _update_score():
	scoreLabel.text = "SCORE: " + str(score)
	if score == 500:
		hiLabel.text = "HI: " + str(score)
		gameEndLabel.text = "YOU WIN"
		gameEndLabel.visible = true
		Autoload.progress += 1
		gameCloseTimer.start()
	pass


func _check_lives():
	if lives > 0:
		respawnTimer.start()
		lifeDisplay.get_child(lostLife - 1).visible = false
		lostLife -= 1
	else:
		gameCloseTimer.start()
		gameEndLabel.text = "GAME OVER"
		gameEndLabel.visible = true
		enemyPhase1.queue_free()
	pass


func _on_respawn_timer_timeout() -> void:
	var ship = shipLoad.instantiate()
	get_tree().get_root().get_node("ArcadeGame").add_child(ship)
	pass


func _on_game_close_timer_timeout() -> void:
	Autoload.time += 1
	get_tree().change_scene_to_file("res://scenes/proto_room.tscn")
	pass
