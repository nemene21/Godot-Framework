extends RefCounted
class_name ComponentData

## Relevant data for components.

var entity: Entity ## The entity this component is under.
var node: Node ## The node this entity is under.


func _init(e: Entity, n: Node) -> void:
	entity = e
	node = n

## Forwards a [code]get_component()[/code] call to the entity.
func get_component(identifier: String) -> void:
	entity.get_component(identifier)
