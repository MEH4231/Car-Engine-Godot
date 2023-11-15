extends Node2D

var MaxSpeed = Vector2(108,108)
var Speed = Vector2(0,0)
var Acceleration = 0
var LastPos = Vector2(0,0)
var Resistance = 0.1

@onready var CarEngine = $Car/Engine2

func _physics_process(delta):
	print("Speed  " + str(Speed))
	print("Accel  " + str(Acceleration))
	print("Res    " + str(Resistance))
	#print("Transform " + str(-$Car.transform.x * Acceleration))
	#print("Transform " + str(-$Car.transform.x))
	#print("Transform " + str($Car.transform))
	#if CarEngine.EngineOn == true:
	var t = CarEngine.Torque / CarEngine.get("GearMult" + str(CarEngine.Gear))
	MaxSpeed = t#Vector2(t,t)
	#print(MaxSpeed / CarEngine.get("GearMult" + str(CarEngine.Gear)) / CarEngine.Power)
	#var a = MaxSpeed / CarEngine.get("GearMult" + str(CarEngine.Gear)) / CarEngine.Power
	#if Speed.x < a and Speed.y < a:
	
	if (Speed.x + Speed.y) / 2 < MaxSpeed:
		Acceleration = CarEngine.Torque * CarEngine.get("GearMult" + str(CarEngine.Gear))# * delta
	else:
		Acceleration = 0
	
	
	
	#print("AAAAAAAAA" + str((CarEngine.Torque * CarEngine.get("GearMult" + str(CarEngine.Gear))) / Resistance))
	#Acceleration = (CarEngine.Torque * CarEngine.get("GearMult" + str(CarEngine.Gear))) / Resistance # * delta
	#else:
		#pass
		#Acceleration /= 2
#		if Resistance != 0:
#			Acceleration *= 1 / Resistance
	#if Resistance != 0:
	#if Resistance > 1 or Resistance < -1:
	$Car.velocity /= Resistance#$Car.velocity * 0.9
		#$Car.velocity = $Car.velocity / 1.1
		#$Car.velocity = lerp($Car.velocity, Vector2(0,0),1 / Resistance)
			#$Car.velocity -= Speed * min(delta/1.0, 1.0)
			#$Car.velocity *= $Car.transform.x
		#Acceleration /= -Resistance
	print("           " + str(-$Car.transform.x * Resistance))
	#$Car.velocity = -$Car.transform.x * Resistance# * delta# / Resistance
	Resistance = (Speed.x + Speed.y) / 2 #/ 50
	if Resistance == 0:
		Resistance += 0.1 
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
		$Car.rotation_degrees -= 3
	if Input.is_action_pressed("Right"):
		$Car.rotation_degrees += 3
	
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
