extends CharacterBody2D

var canclick : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta 
		
	if Input.is_action_pressed("click") && canclick:
		move()
	if Input.is_action_just_released("click"):
		velocity += get_global_mouse_position() * delta
		
	
	var test = move_and_collide(velocity * delta)
	if test:
		velocity.bounce(test.get_normal())
	
	
func move():
	position = get_global_mouse_position()

func _input(event):
	if event.is_pressed(): # Mouse click coordinates
		velocity.x = event.position.x - global_position.x
		velocity.y = event.position.y - global_position.y
	
func _on_area_2d_mouse_entered():
	canclick = true
	



func _on_area_2d_mouse_exited():
	canclick = false
