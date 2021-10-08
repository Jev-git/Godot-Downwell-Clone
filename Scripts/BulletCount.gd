extends Node2D
class_name BulletCount

export var m_psBulletCountSingle: PackedScene

onready var m_iMaxBullet: int = PersistantData.m_iPlayerMaxBulletCount
onready var m_iBulletLeft: int = m_iMaxBullet

func _ready():
	for iBullet in range(m_iMaxBullet):
		var nSprite = m_psBulletCountSingle.instance()
		add_child(nSprite)
		nSprite.position.y = -iBullet * 64

func reload():
	m_iBulletLeft = m_iMaxBullet
	for nBullet in get_children():
		nBullet.visible = true

func shoot():
	if m_iBulletLeft > 0:
		get_child(m_iBulletLeft - 1).visible = false
	m_iBulletLeft -= 1
