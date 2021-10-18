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
		var vCollidePos: Vector2 = TileMapUtil.get_collided_tile_pos(_nOtherBody, global_position)
		if vCollidePos == Vector2(-1, -1):
			return
		else:
			var sTileName: String = _nOtherBody.tile_set.tile_get_name(_nOtherBody.get_cellv(vCollidePos))
			if sTileName == "Prop" or sTileName == "Crate":
				_nOtherBody.set_cellv(vCollidePos, -1)
	elif _nOtherBody.get_class() == "Enemy":
		_nOtherBody.get_shot()
	queue_free()
