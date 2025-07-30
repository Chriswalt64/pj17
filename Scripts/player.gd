extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var isScenePlaying : bool

func _ready():
	if Autoload.lastPosition != null && Autoload.lastPosition != Vector2(0,0):
		position = Autoload.lastPosition
	check_time()

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var hdirection = Input.get_axis("ui_left", "ui_right")
	var vdirection = Input.get_axis("ui_up","ui_down")
	if hdirection:
		velocity.x = hdirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if vdirection:
		velocity.y = vdirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _on_color_rect_minigame_start():
		Autoload.lastPosition = position



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

func _on_pong_guys_minigame_start():
	Autoload.lastPosition = position


func _on_rhythm_game_person_minigame_start():
	Autoload.lastPosition = position
