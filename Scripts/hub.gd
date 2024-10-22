extends Node3D

@onready var warp_td: Area3D = $Warp_TD

enum ZoneToWarpTo {NONE = 0, HUB, TD, TBS, RTS}
var isInWarpZone: bool = false

signal warpToThisZone(NextZone: ZoneToWarpTo)

func _on_warp_td_player_in_zone(inZone: bool) -> void:
	isInWarpZone = inZone
	if inZone:
		emit_signal("warpToThisZone", ZoneToWarpTo.TD)
		print("in TD warp")
	else:
		emit_signal("warpToThisZone", ZoneToWarpTo.NONE)

func ReturnCamera() -> Camera3D: #returns the camera from this scene
	return %HubCamera
