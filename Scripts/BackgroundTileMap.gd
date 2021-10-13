extends TileMap

func _init():
	print_debug(get_used_cells_by_id(1))

#func _input(event):
#	if event is InputEventKey and event.get_scancode() == KEY_SPACE and event.is_pressed():
#		print_debug(set_cellv(Vector2(1, 1), -1))
#		print_debug(get_used_cells_by_id(1))
