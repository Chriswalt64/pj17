extends Area2D

@onready var arcadeGame: Node = get_tree().get_root().get_node("ArcadeGame")
@onready var shootTimer: Node = $ShootTimer
@onready var bulletLoad: Resource = load("res://scenes/arcade_game/enemy_bullet.tscn")

var willShoot: bool = false:
	set(newValue):
		if willShoot != newValue:
			willShoot = newValue
			if willShoot:
				print("willShoot is now TRUE")
				fire_bullet()
			else:
				print("willShoot is now FALSE")


func _process(delta: float) -> void:
	match arcadeGame.phase:
		1:
			if $RayCast2D.is_colliding():
				willShoot = true
			else:
				willShoot = false
		2:
			pass
		_:
			pass
	pass


func _is_it(what):
	return "Enemy" == what


func fire_bullet():
	arcadeGame.enemyBulletSpawn = global_position
	var bullet = bulletLoad.instantiate()
	get_tree().get_root().get_node("ArcadeGame").add_child(bullet)
	pass
