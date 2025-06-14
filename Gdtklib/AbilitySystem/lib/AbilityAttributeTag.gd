extends Node
class_name AbilityAttributeTag

# Stores ability attribute tags. Abilities check these tags to determine if they are usable.
@export var attribute_tag:Dictionary = {}

# The replication_rate is the rate of the replication of the ability tag. 
# If the replication rate is -1, it means that the ability tag is not replicated. The unit of the replication rate is second.
@export var replication_rate:float = -1.0

var timer:Timer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_multiplayer_authority() and replication_rate >0:
		timer = Timer.new()
		timer.set_wait_time(replication_rate)
		timer.set_one_shot(false)
		timer.connect("timeout",self.replicate)
		add_child(timer)
		timer.start()

	pass # Replace with function body.

func replicate():
	rpc("sync_attribute_tag",attribute_tag)

@rpc
func sync_attribute_tag(tag:Dictionary):
	attribute_tag = tag

func add_tag(tag_name:String,tag_val = true):
	attribute_tag[tag_name] = tag_val

func remove_tag(tag_name:String):
	if attribute_tag.has(tag_name):
		attribute_tag.erase(tag_name)

func has_tag(tag_name:String):
	return attribute_tag.has(tag_name)

func get_tag(tag_name:String):
	return attribute_tag[tag_name]
	

