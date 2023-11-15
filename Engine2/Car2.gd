extends RigidBody3D

var MaxSpeed = Vector3(108,108,108)
var Speed = Vector3(0,0,0)
var Acceleration = 0
var LastPos = Vector3(0,0,0)
var Resistance = 0

@onready var CarEngine = $Engine2

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
	print(MaxSpeed / CarEngine.get("GearMult" + str(CarEngine.Gear)) / CarEngine.Power)
	var a = MaxSpeed / CarEngine.get("GearMult" + str(CarEngine.Gear)) / CarEngine.Power
	if Speed.x < a and Speed.y < a:
		Acceleration = (CarEngine.Torque * CarEngine.get("GearMult" + str(CarEngine.Gear)))# * delta
	else:
		pass
		#Acceleration /= 2
#		if Resistance != 0:
#			Acceleration *= 1 / Resistance
	#if Resistance != 0:
	linear_velocity = linear_velocity * 0.99
		#$Car.velocity = $Car.velocity / 1.1
		#$Car.velocity = lerp($Car.velocity, Vector2(0,0),1 / Resistance)
			#$Car.velocity -= Speed * min(delta/1.0, 1.0)
			#$Car.velocity *= $Car.transform.x
		#Acceleration /= -Resistance
	print("           " + str(-transform.basis.x * Resistance))
	#$Car.velocity = -$Car.transform.x * Resistance# * delta# / Resistance
	Resistance = Speed.x / 50          
	Speed = (position - LastPos) / delta
	LastPos = position
	#Acceleration = snappedi(CarEngine.Torque * delta, 1)
	#Speed = 
	#Speed += CarEngine.Torque
	#Speed /= CarEngine.Resistance
	if CarEngine.Gear == 0:
		linear_velocity += -transform.basis.x * Acceleration * delta
	else:
		linear_velocity -= -transform.basis.x * Acceleration * delta
		#$Car.velocity *= -$Car.transform.y * delta
	
	if Input.is_action_pressed("Left"):
		rotation_degrees.y += 100 * delta
	if Input.is_action_pressed("Right"):
		rotation_degrees.y -= 100 * delta
	
	#move_and_slide()

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
