extends Area2D
class_name Prop

export var m_fThreshold: float = 30

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(_nPlayer: Node2D):
	if position.y - _nPlayer.position.y > m_fThreshold:
		_nPlayer.bounce()
		queue_free()
