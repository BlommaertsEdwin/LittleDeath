class_name InventoryStack

var _stack_content:Array[Item] = []
var is_full:bool = false


func add_item(item:Item):
	if not is_full:
		_stack_content.append(item)
	if _stack_content.size() == _stack_content[0].max_stack_count:
		is_full = true
	
func remove_item(item:Item):
	_stack_content.erase(item)
	
func get_items() -> Array[Item]:
	return _stack_content

func display():
	if _stack_content.size() > 0:
		return [_stack_content[0], _stack_content.size()]

func get_type():
	if _stack_content.size() > 0:
		return _stack_content[0]
		
		
