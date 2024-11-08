extends Area3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var label: Label3D = $Label3D
@export var textInBox: String = "Default Text, please change"

enum ZoneToWarpTo {NONE = 0, HUB, TD, TBS, RTS}

signal playerInZone(inZone: bool)

func _ready() -> void:
	label.text = textInBox

func _on_body_entered(_body: Node3D) -> void:
	emit_signal("playerInZone", true)
	label.text = "Press 'E' to Warp"

func _on_body_exited(_body: Node3D) -> void:
	#label.text = "Level Warp Zone"
	label.text = textInBox
	emit_signal("playerInZone", false)
