extends CharacterBody3D


@onready var Path: PathFollow3D = $".."

@export var SPEED: int = 2
@export var HEALTH: int = 5

func _physics_process(delta: float) -> void: 
	#Path.set_progress() is what moves the unit along the path. In this case I am setting current progress as an effect on Speed + delta time
	Path.set_progress(Path.get_progress() + (SPEED * delta)) #makes enemy move at constant speed regardless of computer quality
	
	if Path.get_progress_ratio() >= 0.99: #if progress is more than 99%, then delete the enemy unit
		Path.queue_free() #We delete Path so that the whole node is deleted.

func TakeDamage(damage : int) -> void:
	HEALTH -= damage
	if HEALTH <= 0:
		Path.queue_free()
