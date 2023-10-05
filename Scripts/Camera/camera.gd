# Script for all cameras. Attached to an Area3D which serves as the camera's active range
class_name Camera
extends Camera3D

@export var follow : bool = false            # Is it following the player 
@export var turn_to_face : bool = false      # Is it turning to face the player
@export var turn_speed : int = 60            
@export var follow_dist : int = 5            
@export var follow_speed : int = 2           

var target  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not target:
		return 
	
	# Distance to target (player)
	var to_target : Vector3 = target.global_transform.origin - global_transform.origin
	var target_distance = to_target.length()
	
	# If following, move the camera to the players position 
	if follow:
		# Will slow down as it gets closer, and always stay follow_dist away
		var accel = target_distance - follow_dist
		global_transform.origin += accel * Vector3(to_target.x, 0, to_target.y) * delta * follow_speed
		
	# If turning to face, rotate camera to face player
	if turn_to_face:
		to_target = to_target.normalized()
		# Get up and right vector of camera
		var up = global_transform.basis.y
		var right = global_transform.basis.x
		# Get the angle between player and camera horizontally and vertically
		var r_dot = to_target.dot(right)
		var u_dot = to_target.dot(up)
		# Rotate camera 
		rotation_degrees.y += -r_dot * turn_speed * delta
		rotation_degrees.x += u_dot * turn_speed * delta
	
		

func set_target(body):
	print("setting target")
	target = body
