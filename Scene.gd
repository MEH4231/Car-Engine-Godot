extends Node2D

var Speed = 0
var Acceleration = 0

@onready var CarEngine = $Car/Engine

func _physics_process(delta):
	print("Speed  " + str(Speed))
	print("Accel  " + str(Acceleration))
	print("Transform " + str(-$Car.transform.x * Acceleration))
	print("Transform " + str(-$Car.transform.x))
	print("Transform " + str($Car.transform))
	#if CarEngine.EngineOn == true:
	Acceleration = snappedi(CarEngine.Torque * delta, 1)
	#Speed = 
	#Speed += CarEngine.Torque
	#Speed /= CarEngine.Resistance
	if CarEngine.Gear == 0:
		$Car.velocity += -$Car.transform.x * Acceleration * delta
	else:
		$Car.velocity -= -$Car.transform.x * Acceleration * delta
		$Car.velocity *= -$Car.transform.y * delta
	
	if Input.is_action_pressed("Left"):
		$Car.rotation_degrees -= 2
	if Input.is_action_pressed("Right"):
		$Car.rotation_degrees += 2
	
	$Car.move_and_slide()

func _ready():
	var Size = DisplayServer.screen_get_size() / 2
	get_window().size = Size
	get_window().mode = Window.MODE_FULLSCREEN
	get_window().mode = Window.MODE_WINDOWED
	get_window().position = (DisplayServer.screen_get_size() - Size) / 2
