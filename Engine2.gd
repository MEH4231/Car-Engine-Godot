extends Node

var MaxRPM = 6800
var GearMult0 = 1
var GearMult1 = 1
var GearMult2 = 0.6
var GearMult3 = 0.4
var GearMult4 = 0.25

var Power = 10

var RPM = 0
var Torque = 0
var Gear = 1
var EngineOn = false

func _physics_process(delta):
	print("Gear   " + str(Gear))
	#print("Res    " + str(Resistance))
	print("RPM    " + str(RPM))
	print("Torque " + str(Torque))
	Controls()
	if EngineOn == true:
		RunEngine()
	else:
		EngineOff()
	ComputeTorque()
	

func Controls():
	if Input.is_action_just_pressed("GearUp"):
		if Gear < 4:
			Gear += 1
	if Input.is_action_just_pressed("GearDown"):
		if Gear > 0:
			Gear -= 1
	if Input.is_action_just_pressed("EngineToggle"):
		EngineOn = !EngineOn

func RunEngine():
	if Input.is_action_pressed("Accelerate"):
		if RPM < MaxRPM / get("GearMult" + str(Gear)):
			RPM += Power * get("GearMult" + str(Gear))
	else:
		if RPM <= 800:
			RPM += (RPM / 20) + 1
		elif RPM > 800:
			RPM -= (RPM / 20)

func EngineOff():
	if RPM > 10:
		RPM -= (RPM / 10)
	else:
		RPM = 0

func ComputeTorque():
	if Input.is_action_pressed("Accelerate"):
		if Gear == 0:
			Torque = RPM
		else:
			Torque = (RPM * get("GearMult" + str(Gear)))
	else:
		if Torque > 1.2:
			Torque /= 1.2
		else:
			Torque = 0







