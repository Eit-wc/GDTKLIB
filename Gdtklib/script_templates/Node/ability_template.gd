extends Ability

# this class use the process function for cooldown. please dont use the _process function for other things

func _ready():
	super._ready()


# the override function for check the resource
func _check_resource():
	return true

# the override function for consuming the resource
func _consume_resource():
	pass

# the override function for main ability logic
func _task(val = null):
	pass

func _physics_process(delta):
	pass