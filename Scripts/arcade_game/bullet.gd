extends Area2D

const BULLET_SPEED = 1000

@onready var ship: Node = get_tree().get_root().get_node("ArcadeGame/Ship")
@onready var arcadeGame: Node = get_tree().get_root().get_node("ArcadeGame")


func _ready() -> void:
	position = ship.position
	pass


func _process(delta: float) -> void:
	position.y -= BULLET_SPEED * delta
	pass


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.has_method("_is_it") && area._is_it("Enemy"):
		area.queue_free()
		arcadeGame.score += 100
		arcadeGame._update_score()
		queue_free()
	pass
