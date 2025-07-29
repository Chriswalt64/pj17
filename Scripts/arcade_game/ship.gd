extends CharacterBody2D

const MOVE_SPEED = 500

@onready var bulletLoad: Resource = load("res://scenes/arcade_game/bullet.tscn")
@onready var arcadeGame: Node = get_tree().get_root().get_node("ArcadeGame")
@onready var screen: Node = get_tree().get_root().get_node("ArcadeGame/ScreenCenter/Screen")


func _ready() -> void:
	global_position = Vector2(640, 640)
	pass


func _process(delta: float) -> void:
	var moveDirection: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity.x = moveDirection.x * MOVE_SPEED
	position.x = clamp(position.x, screen.global_position.x + 24, screen.global_position.x + screen.size.x - 24)
	move_and_slide()
	pass


func _is_it(what):
	return "Ship" == what


func fire_bullet():
	var bullet = bulletLoad.instantiate()
	get_tree().get_root().get_node("ArcadeGame").add_child(bullet)
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("space") && arcadeGame.phase != 0:
		fire_bullet()
	pass
