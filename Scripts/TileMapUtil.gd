extends Node2D

func get_collided_tile_pos(_nTileMap: TileMap, _vSelfPos: Vector2) -> Vector2:
	_vSelfPos.y -= 1024 * (int(_vSelfPos.y) / 1024)
	var vTileMapScale: Vector2 = _nTileMap.scale
	var vCollidePos: Vector2 = _nTileMap.world_to_map(Vector2(_vSelfPos.x / vTileMapScale.x, _vSelfPos.y / vTileMapScale.y))
	
	if _nTileMap.get_cellv(vCollidePos + Vector2(0, 1)) != -1:
		return vCollidePos + Vector2(0, 1)
	elif _nTileMap.get_cellv(vCollidePos + Vector2(-1, 1)) != -1:
		return vCollidePos + Vector2(-1, 1)
	elif _nTileMap.get_cellv(vCollidePos + Vector2(1, 1)) != -1:
		return vCollidePos + Vector2(1, 1)
	else:
		return Vector2(-1, -1)
