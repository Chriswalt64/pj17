extends ColorRect

var can_move : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("click") && can_move:
		move()
	
func move():
	position = get_global_mouse_position()


func _on_mouse_entered():
	can_move = true


func _on_mouse_exited():
	if Input.is_action_pressed("click") == false:
		can_move = false
