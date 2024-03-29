class_name InventoryDialog
extends PanelContainer

@export var slot_scene: PackedScene
@onready var grid_container:GridContainer = %GridContainer


func _clear_gridcontainer():
	for child in grid_container.get_children():
		child.queue_free()

func open(inventory:Inventory):
	show()
	_clear_gridcontainer()
	
	for item in inventory.get_items():
		var slot = slot_scene.instantiate()
		grid_container.add_child(slot)
		slot.display(item.display())

func _on_close_button_pressed():
	hide()
	
	# Replace with function body.
