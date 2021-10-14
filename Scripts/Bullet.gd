extends Area2D
class_name Bullet

export var m_fSpeed: float = 1000

func get_class():
	return "Bullet"

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _physics_process(delta):
	position.y += m_fSpeed * delta

func _on_body_entered(_nOtherBody: Node2D):
	if _nOtherBody is TileMap:
		var vCollidePos: Vector2 = _get_collided_tile_pos(_nOtherBody)
		if vCollidePos == Vector2(-1, -1):
			return
		else:
			match _nOtherBody.tile_set.tile_get_name(_nOtherBody.get_cellv(vCollidePos)):
				"Prop", "Crate":
					_nOtherBody.set_cellv(vCollidePos, -1)
	elif _nOtherBody.get_class() == "Enemy":
		_nOtherBody.get_shot()
	queue_free()

func _get_collided_tile_pos(_nTileMap: TileMap) -> Vector2:
	var vTileMapScale: Vector2 = _nTileMap.scale
	var vCollidePos: Vector2 = _nTileMap.world_to_map(Vector2(global_position.x / vTileMapScale.x, global_position.y / vTileMapScale.y))
	
	if _nTileMap.get_cellv(vCollidePos) != -1:
		return vCollidePos
	elif _nTileMap.get_cellv(vCollidePos + Vector2(0, 1)) != -1:
		return vCollidePos + Vector2(0, 1)
	elif _nTileMap.get_cellv(vCollidePos + Vector2(-1, 1)) != -1:
		return vCollidePos + Vector2(-1, 1)
	elif _nTileMap.get_cellv(vCollidePos + Vector2(1, 1)) != -1:
		return vCollidePos + Vector2(1, 1)
	else:
		return Vector2(-1, -1)
