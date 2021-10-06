extends KinematicBody2D
class_name BadBubble

export var m_iHP: int = 3
export var m_fMoveSpeed: float = 60

onready var m_nPlayer: Player = get_tree().get_nodes_in_group("Player")[0]
onready var m_nHitBox: Area2D = $HitBox
onready var m_nHurtBox: Area2D = $HurtBox

func _ready():
	m_nHitBox.connect("body_entered", self, "_on_body_entered")
	m_nHitBox.connect("area_entered", self, "_on_area_entered")
	m_nHurtBox.connect("body_entered", self, "_damage_player")

func _physics_process(delta):
	move_and_slide((m_nPlayer.position - position).normalized() * m_fMoveSpeed)

func _on_body_entered(_nOtherBody: Node2D):
	if _nOtherBody.get_class() == "Player":
		_nOtherBody.bounce()
		queue_free()

func _on_area_entered(_nOtherArea: Area2D):
	if _nOtherArea.get_class() == "Bullet":
		_take_damage(1)

func _damage_player(_nPlayer: Node2D):
	pass

func _take_damage(_iDamage: int):
	m_iHP -= _iDamage
	if m_iHP <= 0:
		queue_free()
