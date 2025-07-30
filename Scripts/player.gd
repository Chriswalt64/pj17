extends CharacterBody2D


const SPEED = 400.0

@onready var stairDialogueLabel: Node = $StairDialogue
@onready var sprite: Node = $Sprite2D

var isScenePlaying : bool

func _ready():
	if Autoload.lastPosition != null && Autoload.lastPosition != Vector2(0,0):
		position = Autoload.lastPosition
	check_time()


func _physics_process(delta):
	var moveDir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if moveDir:
		velocity = moveDir * SPEED
		sprite.rotation = moveDir.angle()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	print(moveDir)
	move_and_slide()


func _it_is(what):
	return "player" == what


func check_time():
	if Autoload.time == 10:
		print("Morning Has Come!")
		if Autoload.progress < 4:
			print("YOU LOSE LOSER BABY GO CRY ABOUT IT") #replace this with lose event
		else:
			print("YOU WIN GOOD JOB COOL GUY") #replace with win event
	elif Autoload.time > 5 && Autoload.time < 10:
		print("Morning Draws Near...")
	elif Autoload.time == 0:
		print("The Night Begins.")
	else:
		print("The Night Goes On.")


func _on_item_find_person_minigame_start() -> void:
	Autoload.lastPosition = position


func _on_pong_person_minigame_start() -> void:
	Autoload.lastPosition = position


func _on_arcade_person_minigame_start() -> void:
	Autoload.lastPosition = position


func _on_rhythm_person_minigame_start() -> void:
	Autoload.lastPosition = position


func _on_stair_base_body_entered(body: Node2D) -> void:
	if body.has_method("_it_is") && body._it_is("player"):
		stairDialogueLabel.visible = true


func _on_stair_base_body_exited(body: Node2D) -> void:
	if body.has_method("_it_is") && body._it_is("player"):
		stairDialogueLabel.visible = false
