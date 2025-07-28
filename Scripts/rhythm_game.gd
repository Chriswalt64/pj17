extends Node2D

@onready var resultLabel: Node = $ResultLabel
@onready var resultLabelTimer: Node = $ResultLabel/ResultLabelTimer
@onready var gameCloseTimer: Node = $GameCloseTimer
@onready var newNoteLoad: Resource = load("res://scenes/note.tscn")

var canBeat: bool
var score: int = 0
var scoreValue: int = 0
var result: String
var upInput: bool = Input.is_action_just_pressed("ui_up")
var newText: String = "BAD!!"
var newSize: int = 40
var lastNumber: int = 0
var progressCounter: int = 0
var gameDone: bool


func _ready() -> void:
	var newNote: Node = newNoteLoad.instantiate()
	get_tree().get_root().get_node("RhythmGame").add_child(newNote)
	pass


func _on_good_area_entered(area: Area2D) -> void:
	if area.has_method("_is_it") && area._is_it("Note"):
		result = "Good"
	pass


func _on_perfect_area_entered(area: Area2D) -> void:
	if area.has_method("_is_it") && area._is_it("Note"):
		result = "Perfect"
	pass


func _on_perfect_area_exited(area: Area2D) -> void:
	if area.has_method("_is_it") && area._is_it("Note"):
		result = "Good"
	pass


func _on_good_area_exited(area: Area2D) -> void:
	if area.has_method("_is_it") && area._is_it("Note"):
		result = ""
	pass


func _on_beat_audio_area_entered(area: Area2D) -> void:
	if area.has_method("_is_it") && area._is_it("Note"):
		$AudioController/BeatAudio/Beat.play()
	pass


func check_progress():
	match result:
		"Good":
			newText = "Good"
			newSize = 28
			scoreValue = 1
		"Perfect":
			newText = "Perfect..."
			newSize = 16
			scoreValue = 2
		_:
			newText = "BAD!!"
			newSize = 32
			scoreValue = 0
	_update_score()
	print(score)
	if progressCounter < 5:
		_display_result()
		_spawn_note()
	else:
		$ResultLabel/ResultLabelBackground.visible = true
		if score >= 5:
			newText = "GREAT BEATS"
			newSize = 48
			_display_result()
			resultLabelTimer.stop()
		else:
			newText = "THAT FUCKING SUCKED ASS"
			newSize = 48
			_display_result()
			resultLabelTimer.stop()
			Autoload.progress += 1
		gameCloseTimer.start()


func _display_result():
	resultLabel.text = ""
	resultLabel.text += newText
	resultLabel.label_settings.font_size = newSize
	#var spawnPointPosition: Node = get_tree().get_root().get_node("RhythmGame/TextSpawnPositions/" + get_display_spawn())
	#resultLabel.position = spawnPointPosition.position
	resultLabelTimer.start()
	pass


func get_display_spawn(): #originally used to spawn the result message in a random spot. Scrapped it, but keeping the code for later use
	var randomNumber = randi_range(1, 9)
	while randomNumber == lastNumber:
		randomNumber = randi_range(1, 9)
	lastNumber = randomNumber
	return str(randomNumber)


func _on_result_label_timer_timeout() -> void:
	resultLabel.text = ""
	pass


func _update_score():
	score += scoreValue
	pass


func _spawn_note():
	var newNote: Node = newNoteLoad.instantiate()
	get_tree().get_root().get_node("RhythmGame").add_child(newNote)
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("space") && canBeat:
		progressCounter += 1
		check_progress()
	pass


func _on_game_close_timer_timeout() -> void:
	Autoload.time += 1
	get_tree().change_scene_to_file("res://scenes/proto_room.tscn")
	pass
