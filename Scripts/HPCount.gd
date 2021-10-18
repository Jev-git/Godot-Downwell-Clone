extends Node2D
class_name HPCount

onready var m_iMaxHP: int = PersistantData.m_iPlayerMaxHP
onready var m_iCurrentHP: int = PersistantData.m_iPlayerCurrentHP

onready var m_nLabel: Label = $Label

func _ready():
	_update_label()

func _update_label():
	m_nLabel.text = "HP: %d/%d" % [m_iCurrentHP, m_iMaxHP]

func take_damage():
	m_iCurrentHP -= 1
	_update_label()
