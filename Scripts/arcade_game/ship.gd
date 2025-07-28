extends CharacterBody2D

const MOVE_SPEED = 500

@onready var bulletLoad: Resource = load("res://scenes/arcade_game/bullet.tscn")


func _ready() -> void:
	global_position = Vector2(640, 640)
	pass


func _process(delta: float) -> void:
	var moveDirection: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity.x = moveDirection.x * MOVE_SPEED
	move_and_slide()
	pass


func _is_it(what):
	return "Ship" == what


func fire_bullet():
	var bullet = bulletLoad.instantiate()
	get_tree().get_root().get_node("ArcadeGame").add_child(bullet)
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		fire_bullet()
	pass
