extends Node3D

@onready var warp_td: Area3D = $Warp_TD
@onready var warp_tbs: Area3D = $Warp_TBS

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

func _on_warp_tbs_player_in_zone(inZone: bool) -> void:
	isInWarpZone = inZone
	if inZone:
		emit_signal("warpToThisZone", ZoneToWarpTo.TBS)
		print("in TBS warp")
	else:
		emit_signal("warpToThisZone", ZoneToWarpTo.NONE)

func ReturnCamera() -> Camera3D: #returns the camera from this scene
	return %HubCamera
