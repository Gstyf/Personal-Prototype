extends Node3D

@export var unitList : Array[CharacterBody3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children = $".".get_children()
	for child in children:
		unitList.append(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
