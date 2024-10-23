extends Node3D


enum ACTIVE_GAME_MODE { MENU, HUB, TD, TBS, RTS }
var currentMode: ACTIVE_GAME_MODE = ACTIVE_GAME_MODE.HUB


@onready var hub: Node3D = $Hub
@onready var tower_defence: Node3D = $TowerDefence
@onready var turn_based_strategy: Node3D = %TurnBasedStrategy


@onready var main_camera: Camera3D = $MainCamera
@onready var activeNode: Node3D = hub #change this to menu later if appropriate

enum SceneToLoad { NONE, HUB, TD, TBS, RTS }
@export var nextZone: SceneToLoad

func _ready() -> void:
	activeNode.visible = true
	activeNode.process_mode = Node.PROCESS_MODE_INHERIT
	main_camera = hub.ReturnCamera()
	main_camera.make_current()

func _input(event: InputEvent) -> void:
	if currentMode == ACTIVE_GAME_MODE.HUB:
		HandleHubSceneSelection(event)

func HandleHubSceneSelection(event: InputEvent) -> void: #this might not be the most elegant way to handle this
	if event.is_action_pressed("action_activate"):
		match nextZone:
			SceneToLoad.NONE:
				print("going nowhere")
			SceneToLoad.HUB:
				pass
			SceneToLoad.TD:
				activeNode.visible = false
				activeNode.process_mode = Node.PROCESS_MODE_DISABLED
				activeNode = tower_defence
				activeNode.visible = true
				activeNode.process_mode = Node.PROCESS_MODE_INHERIT
				main_camera = tower_defence.ReturnCamera()
				main_camera.make_current()
				print("loading TD level!")
			SceneToLoad.TBS:
				activeNode.visible = false
				activeNode.process_mode = Node.PROCESS_MODE_DISABLED
				activeNode = turn_based_strategy
				activeNode.visible = true
				activeNode.process_mode = Node.PROCESS_MODE_INHERIT
				main_camera = turn_based_strategy.ReturnCamera()
				main_camera.make_current()
				print("loading TBS level!")
			SceneToLoad.RTS:
				pass

func _on_hub_warp_to_this_zone(NextZone: SceneToLoad) -> void:
	nextZone = NextZone
