extends Node3D

signal tileClicked(Area3D)

@onready var grid: Node3D = $Grid

const GRID_TILE = preload("res://Scenes/TurnBasedStrategy/grid_tile.tscn")
var gridTile : PackedScene = GRID_TILE
@export var gridWidth = 0
@export var gridDepth = 0

@export var tileDictionary = {} #Dictionary for storing tiles in scene, key is Vector2 for position on tiles.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DrawGrid(gridWidth, gridDepth)
	Events.connect("tileWasClicked", _on_tileWasClicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # Replace with function body.

func ReturnCamera() -> Camera3D: #returns the camera from this scene
	return %TBSCamera

func DrawGrid(width : int, height : int) -> void: #Draw out grid by rendering a shitload of tiles.
	var children = %MapGrid.get_children() # if there already are tiles on the map, get rid of those child nodes first!
	if children.size() > 0:
		for child in children: # remove all existing children (if any) and then repopulate the node with tiles
			child.free() 
	
	var xOffset : int = gridWidth # calculate offset of grid on x axis
	if gridWidth % 2 != 0:
		xOffset = gridWidth + 1
	
	var zOffset : int = gridDepth # calculate offset of grid on z axis
	if gridDepth % 2 != 0:
		zOffset = gridDepth + 1
	
	for x in gridWidth:
		for z in gridDepth:
			var tempTile : Node3D = gridTile.instantiate()
			tempTile.position = Vector3((x * 2) - xOffset, 0, (z * 2) - zOffset)
			get_node("%MapGrid").add_child(tempTile)
			tileDictionary[Vector2(x, z)] = tempTile

func _on_tileWasClicked(tile: Area3D):
	var key = tileDictionary.find_key(tile)
	print("The tile that was clicked was tile " + str(key))	
	pass
