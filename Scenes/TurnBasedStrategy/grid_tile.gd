extends Node3D

@onready var grid_mesh: MeshInstance3D = $GridMesh

enum currentState { EMPTY, PLAYER, ENEMY, INRANGE }
var state = currentState.EMPTY
var previousState = currentState.EMPTY
var isOccupied: bool = false
var isHovered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		currentState.EMPTY:
			if isHovered == false:
				grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareBlack.tres"))
		currentState.PLAYER:
			grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareWhite.tres"))
		currentState.ENEMY:
			grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareRed.tres"))
		currentState.INRANGE:
			if isHovered == false:
				grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareYellow.tres"))

func _displayInRange():
	previousState = state
	state = currentState.INRANGE

func _returnTileState():
	state = previousState
	pass

func _on_mouse_entered() -> void: #Change colour outline of tile when hovered (unless occupied)
	if state == currentState.EMPTY:
		isHovered = true
		grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareYellow.tres"))
	elif state == currentState.INRANGE:
		isHovered = true
		grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareRed.tres"))

func _on_mouse_exited() -> void: #returns the colour of the tile to its previous state
	if state == currentState.EMPTY:
		isHovered = false
		grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareBlack.tres"))
	if state == currentState.INRANGE:
		isHovered = false
		grid_mesh.set_surface_override_material(0, preload("res://Materials/M_SquareYellow.tres"))

func _on_body_entered(body: Node3D) -> void: #update the tile to reflect if a unit is on it
	if body.is_in_group("TBSCharacter"):
		isOccupied = true
		state = currentState.PLAYER
	elif body.is_in_group("TBSEnemy"):
		isOccupied = true
		state = currentState.ENEMY

func _on_body_exited(body: Node3D) -> void: #update the tile to reflect it has no unit on it
	if body.is_in_group("TBSCharacter") or body.is_in_group("TBSEnemy"):
		isOccupied = false
		state = currentState.EMPTY

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if Input.is_action_just_pressed("leftClick") and (state == currentState.EMPTY or state == currentState.INRANGE): 
		Events.emit_signal("tileWasClicked", self)
	elif Input.is_action_just_pressed("leftClick") and (state == currentState.PLAYER or state == currentState.ENEMY):
		Events.emit_signal("unitTileWasClicked", self, state)
