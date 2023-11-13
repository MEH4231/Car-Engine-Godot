extends Node2D

var MaxSpeed = 108
var Speed = Vector2(0,0)
var Acceleration = 0
var LastPos = Vector2(0,0)
var Resistance = 0

@onready var CarEngine = $Car/Engine2

func _physics_process(delta):
	print("Speed  " + str(Speed))
	print("Accel  " + str(Acceleration))
	print("Res    " + str(Resistance))
	#print("Transform " + str(-$Car.transform.x * Acceleration))
	#print("Transform " + str(-$Car.transform.x))
	#print("Transform " + str($Car.transform))
	#if CarEngine.EngineOn == true:
	MaxSpeed = CarEngine.Torque / CarEngine.get("GearMult" + str(CarEngine.Gear))
	
	if Speed.x < MaxSpeed / CarEngine.get("GearMult" + str(CarEngine.Gear)):
		Acceleration = (CarEngine.Torque * CarEngine.get("GearMult" + str(CarEngine.Gear)))# * delta
	else:
		pass
	$Car.velocity -= -$Car.transform.x * Resistance# * delta# / Resistance
	Resistance = Speed.x / 50          
	Speed = ($Car.position - LastPos) / delta
	LastPos = $Car.position
	#Acceleration = snappedi(CarEngine.Torque * delta, 1)
	#Speed = 
	#Speed += CarEngine.Torque
	#Speed /= CarEngine.Resistance
	if CarEngine.Gear == 0:
		$Car.velocity += -$Car.transform.x * Acceleration * delta
	else:
		$Car.velocity -= -$Car.transform.x * Acceleration * delta
		#$Car.velocity *= -$Car.transform.y * delta
	
	if Input.is_action_pressed("Left"):
		$Car.rotation_degrees -= 2
	if Input.is_action_pressed("Right"):
		$Car.rotation_degrees += 2
	
	$Car.move_and_slide()

func _enter_tree():
	LastPos = position

func _ready():
	LastPos = position
	if OS.get_name() == "Linux":
		var Size = DisplayServer.screen_get_size() / 2
		get_window().size = Size
		get_window().mode = Window.MODE_FULLSCREEN
		get_window().mode = Window.MODE_WINDOWED
		get_window().position = (DisplayServer.screen_get_size() - Size) / 2
