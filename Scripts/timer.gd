extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str($"../Timer".time_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = get_converted_time($"../Timer".time_left)

func get_converted_time(time: float) -> String:
	print(time)
	var seconds: int = time
	var milliseconds: int = (time - seconds) * 100
	var time_string: String = "%02d:%02d" % [seconds, milliseconds]
	return time_string
