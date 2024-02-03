extends CanvasLayer

@onready var hero = %Hero
@onready var inventory_dialog = %InventoryDialog

func _unhandled_input(event):
	if event.is_action_released("inventory"):
		inventory_dialog.open(hero.inventory)
