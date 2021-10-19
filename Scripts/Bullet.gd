extends KinematicBody2D
class_name Bullet

export var m_fSpeed: float = 20

func get_class():
	return "Bullet"

func _physics_process(delta):
	position.y += m_fSpeed * delta
	var oCollision: KinematicCollision2D = move_and_collide(Vector2.DOWN * m_fSpeed)
	if oCollision:
		if oCollision.collider is TileMap:
			var nTileMap: TileMap = oCollision.collider
			var vCollidePos: Vector2 = TileMapUtil.get_collided_tile_pos(nTileMap, global_position)
			var sTileName: String = nTileMap.tile_set.tile_get_name(nTileMap.get_cellv(vCollidePos))
			if sTileName == "Prop" or sTileName == "Crate":
				nTileMap.set_cellv(vCollidePos, -1)
		elif oCollision.collider.get_class() == "Enemy":
			oCollision.collider.get_shot()
		queue_free()
