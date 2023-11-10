extends Node

var EngineOn = false

var Speed = 0
var RPM = 0
var GearMaxRPM1 = 3500
var GearMaxRPM2 = 5800
var GearMaxRPM3 = 7200
var GearMaxRPM4 = 10000

func _physics_process(_delta):
	print(RPM)
	Controls()
	if EngineOn == true:
		RunEngine()
	else:
		EngineOff()

func Controls():
	if Input.is_action_just_pressed("EngineToggle"):
		EngineOn = !EngineOn

func RunEngine():
	if Input.is_action_pressed("Accelerate"):
		RPM += 500
	elif Input.is_action_pressed("Brake"):
		pass
	else:
		if RPM <= 500:
			RPM += (RPM / 10) + 1
		elif RPM > 500:
			RPM -= (RPM / 10)

func EngineOff():
	if RPM > 10:
		RPM -= (RPM / 10)
	else:
		RPM = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


