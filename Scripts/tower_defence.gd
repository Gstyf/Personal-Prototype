extends Node3D

@onready var td_camera_pos: Node3D = %TDCameraPos
@onready var spawn_timer: Timer = $SpawnTimer

@onready var enemy: PackedScene = preload("res://Scenes/TowerDefence/Enemy.tscn")

@onready var path_one: Path3D = $PathOne
@onready var path_two: Path3D = $PathTwo

var enemiesToSpawn : int = 17 #How many enemies can spawn in total
var canSpawn : bool = true #If a new enemy can spawn yet, reset by timer

func _process(delta: float) -> void:
	GameManager()

func GameManager() -> void:
	if enemiesToSpawn > 0 and canSpawn:
		$SpawnTimer.start()
		var tempEnemy = enemy.instantiate() #Create a temporary object of an enemy
		if(randi() % 2 == 0): #Pick one of the two paths at random, about 50-50 chance
			$PathOne.add_child(tempEnemy) #Add new tempEnemy to PathOne to follow
		else:
			$PathTwo.add_child(tempEnemy) #Add new tempEnemy to PathTwo to follow
		
		enemiesToSpawn -= 1
		canSpawn = false
		print("spawned enemy")

func _on_spawn_timer_timeout() -> void:
	canSpawn = true #Reset so that the next enemy can spawn

func ReturnCamera() -> Camera3D: #returns the camera from this scene
	return $TDCamera	
