extends Node2D

var Speed = 0
var Acceleration = 0

@onready var CarEngine = $Car/Engine

func _physics_process(delta):
	print("Speed  " + str(Speed))
	print("Accel  " + str(Acceleration))
	#if CarEngine.EngineOn == true:
	Acceleration = CarEngine.Torque * delta
	#Speed = 
	#Speed += CarEngine.Torque
	#Speed /= CarEngine.Resistance
	if CarEngine.Gear == 0:
		$Car.velocity += -$Car.transform.x * Acceleration * delta
	else:
		$Car.velocity -= -$Car.transform.x * Acceleration * delta
	$Car.velocity /= CarEngine.Resistance
	
	if Input.is_action_pressed("Left"):
		$Car.rotation_degrees -= 2
	if Input.is_action_pressed("Right"):
		$Car.rotation_degrees += 2
	
	$Car.move_and_slide()
