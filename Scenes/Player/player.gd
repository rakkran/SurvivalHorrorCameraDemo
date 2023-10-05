# Player class
# TO ADD: animation smoothing, nicer movement, etc.
class_name Player
extends CharacterBody3D

@onready var animation_player = $AnimationPlayer

const MOVE_SPEED = 5
const TURN_SPEED = 180
const MAX_FALL_SPEED = 30 
const GRAVITY : float = 9.8

var friction : float = 20.0
var input_dir : Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Get input 
	input_dir = Input.get_vector("turn_left", "turn_right", "forward", "back")
	# Rotate player (tank controls)
	rotate_y(deg_to_rad(-input_dir.x * TURN_SPEED * delta)) 
	# As the player only ever moves on the Z axis, transform along it
	velocity = (global_transform.basis.z * MOVE_SPEED * -input_dir.y)
	move_and_slide()
	
	# Animation 
	if input_dir.y == 0:
		play_anim("idle")
	else:
		play_anim("walk_forward")

func play_anim(action : String):
	if animation_player.current_animation == action:
		return
	animation_player.play(action)
