extends Node

var GearRatio0 = 1
var GearRatio1 = 1
var GearRatio2 = 0.8
var GearRatio3 = 0.5
var GearRatio4 = 0.3
var GearMaxRPM0 = 2800
var GearMaxRPM1 = 3500
var GearMaxRPM2 = 6000
var GearMaxRPM3 = 7800
var GearMaxRPM4 = 9600

var Power = 100
var Resistance = 1

var RPM = 0
var Torque = 0
var Gear = 1
var EngineOn = false



func _physics_process(_delta):
	print("Gear   " + str(Gear))
	print("Res    " + str(Resistance))
	print("RPM    " + str(RPM))
	print("Torque " + str(Torque))
	Controls()
	if EngineOn == true:
		RunEngine()
	else:
		EngineOff()
	ComputeTorque()
	
	SnapToInt()

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
		if RPM < get("GearMaxRPM" + str(Gear)):
			RPM += (Power / Resistance) * get("GearRatio" + str(Gear))
			RPM += 1
		elif RPM > get("GearMaxRPM" + str(Gear)):
			RPM -= ((get("GearMaxRPM" + str(Gear)) / (Gear + 1)) / 100)
	else:
		if RPM <= 800:
			RPM += (RPM / 20) + 1
		elif RPM > 800:
			RPM -= (RPM / 20)
	if Input.is_action_pressed("Brake"):
		pass

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
			Torque = (RPM / Gear)
	else:
		if Torque > Resistance:
			Torque -= Resistance
		else:
			Torque = 0
	Resistance = Torque / Power
	if Resistance < 1:
		Resistance = 1

func SnapToInt():
	Resistance = snappedi(Resistance, 1)
	Torque = snappedi(Torque, 1)
	RPM = snappedi(RPM ,1)


