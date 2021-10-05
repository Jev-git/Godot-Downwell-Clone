extends Area2D
class_name Bullet

export var m_fSpeed: float = 1000

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _physics_process(delta):
	position.y += m_fSpeed * delta

func _on_body_entered(_nOtherBody: Node2D):
	queue_free()
