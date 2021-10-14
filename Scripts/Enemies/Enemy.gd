extends KinematicBody2D
class_name Enemy

export var m_iHP: int
export var m_fMoveSpeed: float
export var m_fKnockBackSpeed: float = 60
export var m_fKnockBackDuration: float = 0.1

export var m_bCanBeShot: bool = true
export var m_bCanBeStomped: bool = true

onready var m_nPlayer: Player = get_tree().get_nodes_in_group("Player")[0]
onready var m_nHitBox: Area2D = $HitBox
onready var m_nHurtBox: Area2D = $HurtBox
onready var m_nKnockBackTimer: Timer = $KnockBackTimer
onready var m_bIsKnockingBack: bool = false

func _ready():
	m_nHurtBox.connect("body_entered", self, "_on_body_entered")
	m_nHitBox.connect("body_entered", self, "_damage_player")
	m_nKnockBackTimer.connect("timeout", self, "_on_knock_back_timeout")

func get_class():
	return "Enemy"

func _on_body_entered(_nOtherBody: Node2D):
	if _nOtherBody.get_class() == "Player" and m_bCanBeStomped:
		_nOtherBody.bounce()
		queue_free()

func _damage_player(_nPlayer: Node2D):
	if _nPlayer.get_class() == "Player":
		_nPlayer.take_damage(self.position)

func _take_damage(_iDamage: int):
	m_iHP -= _iDamage
	if m_iHP <= 0:
		queue_free()
	else:
		m_nKnockBackTimer.start(m_fKnockBackDuration)
		m_bIsKnockingBack = true

func _on_knock_back_timeout():
	m_bIsKnockingBack = false

func _process(delta):
	$Sprite.flip_h = true if m_nPlayer.position.x > position.x else false

func _physics_process(delta):
	if m_bIsKnockingBack:
		move_and_slide(Vector2(0, m_fKnockBackSpeed))

func get_shot():
	if m_bCanBeShot:
		_take_damage(1)
