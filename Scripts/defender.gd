extends StaticBody3D

var projectile : PackedScene = preload("res://Scenes/TowerDefence/projectile.tscn")
@export var bulletDamage: int = 3
var currentTargets: Array = []
var curr  : CharacterBody3D
var canShoot : bool = true

func _process(delta: float) -> void:
	if is_instance_valid(curr): #if there is a current target
		look_at(curr.global_position) #rotate to face target
		if canShoot:
			Shoot()
			canShoot = false
			$ShootingCoolDown.start()
	else: #if there is no current target, delete any existing bullets in the air
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
			print("purge all bullets!")

func ChooseTarget(currentTargets: Array) -> void: #function for deciding who to shoot at
	var tempArray : Array = currentTargets
	var currentTarget : CharacterBody3D = null
	for i in tempArray:
		if currentTarget == null: #if there is no current target, target first in list
			currentTarget = i
		else: #if already a target, still prioritise whoever has the most progress towards end
			if i.get_parent().get_progress() > currentTarget.get_parent().get_progress():
				currentTarget = i
	curr = currentTarget #set which target to shoot at

func Shoot() -> void: #function for shooting projectile
	var tempProjectile: CharacterBody3D = projectile.instantiate() #instantiate projectile
	tempProjectile.target = curr #set target
	tempProjectile.damage = bulletDamage #make damage of projectile same as defender's
	get_node("BulletContainer").add_child(tempProjectile) #add projectiles to node containing projectiles
	tempProjectile.global_position = $MeshInstance3D/MarkerToAim.global_position #start the projectile from the aim marker's global position

func _on_enemy_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		currentTargets.append(body)
		ChooseTarget(currentTargets)

func _on_enemy_detector_body_exited(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		currentTargets.erase(body)
		ChooseTarget(currentTargets)


func _on_shooting_cool_down_timeout() -> void:
	canShoot = true
