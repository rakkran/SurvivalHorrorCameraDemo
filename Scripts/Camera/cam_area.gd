# Class for area3Ds in which the associated camera is active. 
# Moving between these areas should switch cameras accordingly.
class_name CameraArea
extends Area3D

var camera : Camera3D 
var target 

func _ready():
	for child in get_children():
		if child is Camera3D:
			camera = child
	body_entered.connect(enable_camera)
	
func enable_camera(body):
	# Switches the current camera to the associated player
	if body.name.to_lower() != "player":
		return
	if camera: 
		camera.make_current()
		if camera.has_method("set_target"):
			camera.set_target(body)
		

	
