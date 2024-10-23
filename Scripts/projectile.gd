extends CharacterBody3D

var target : CharacterBody3D
var speed : int = 20
var damage : int

func _physics_process(delta: float) -> void: #function to make projectile move towards and face the target
	if is_instance_valid(target): #while the target is valid move towards it
		velocity = global_position.direction_to(target.global_position) * speed
		look_at(target.global_position)
		
		move_and_slide() #See about adding a sine-wave to make the projectile arch
	else: #if no valid target, delete projectile
		queue_free()


func _on_collision_body_entered(body: Node3D) -> void: #Signal that if enemy entered projectiles collider, damage it and delete projectile
	if body.is_in_group("Enemy"):
		body.TakeDamage(damage)
		print("hit!")
		queue_free()
