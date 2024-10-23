extends Area3D

@onready var clickable_area: CollisionShape3D = $ClickableArea
@onready var area_indicator: MeshInstance3D = $ClickableArea/AreaIndicator
@export var showAreaIndicator : bool = false

const DEFENDER = preload("res://Scenes/TowerDefence/defender.tscn")
var hasDefender : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_indicator.visible = showAreaIndicator

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	print("Mouse over area!")

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if Input.is_action_just_pressed("leftClick") and !hasDefender:
		print("You clicked me!")
		hasDefender = true
		DEFENDER.instantiate()
