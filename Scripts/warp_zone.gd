extends Area3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var label: Label3D = $Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("spawned in")

func _on_body_entered(body: Node3D) -> void:
	print("you're in zone")
	label.text = "Press 'E' to Warp"

func _on_body_exited(body: Node3D) -> void:
	label.text = "Level Warp Zone"
