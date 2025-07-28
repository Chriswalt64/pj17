extends Area2D

const BULLET_SPEED = 750

@onready var ship: Node = get_tree().get_root().get_node("ArcadeGame/Ship")
@onready var arcadeGame: Node = get_tree().get_root().get_node("ArcadeGame")


func _ready() -> void:
	position = arcadeGame.enemyBulletSpawn
	pass


func _process(delta: float) -> void:
	position.y += BULLET_SPEED * delta
	if arcadeGame.lives == 0:
		queue_free()
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_is_it") && body._is_it("Ship"):
		body.queue_free()
		arcadeGame.lives -= 1
		arcadeGame._check_lives()
		queue_free()
	pass
