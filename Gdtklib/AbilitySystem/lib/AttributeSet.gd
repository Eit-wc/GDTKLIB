extends Node
class_name AbilityAttributeSet

# This class use to store dictionary of attribute and attribute tag
var attribute_dict:Dictionary = {}
var attribute_tag:AbilityAttributeTag 


# Called when the node enters the scene tree for the first time.
func _ready():
	for n in get_children():
		if n is AbilityAttribute:
			attribute_dict[n.name] = n
		elif n is AbilityAttributeTag:
			attribute_tag = n



