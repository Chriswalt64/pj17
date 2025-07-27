extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	if Autoload.lastPosition != null && Autoload.lastPosition != Vector2(0,0):
		position = Autoload.lastPosition

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
