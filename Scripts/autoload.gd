extends Node

var progress: int = 0
var time: int = 0
var lastPosition : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_last_position(position: Vector2):
	lastPosition = position
