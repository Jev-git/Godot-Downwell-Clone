extends Node2D

onready var m_iScreenHeight: int = ProjectSettings.get_setting("display/window/size/height")
onready var m_aiMapChunks: Array = [0, 1, 2, 2, 1, 1, 2, 1, 3]
onready var m_anMapChunks: Array = [
	preload("res://Scenes/Maps/Chunks/MapChunk0.tscn"),
	preload("res://Scenes/Maps/Chunks/MapChunk1.tscn"),
	preload("res://Scenes/Maps/Chunks/MapChunk2.tscn"),
	preload("res://Scenes/Maps/Chunks/MapChunk3.tscn")
]
onready var m_anEnemies: Array = [
	preload("res://Scenes/Enemies/BadBubble.tscn"),
	preload("res://Scenes/Enemies/Bat.tscn"),
	preload("res://Scenes/Enemies/Turtle.tscn")
]

func _ready():
	for iChunk in m_aiMapChunks.size():
		var nChunk = m_anMapChunks[m_aiMapChunks[iChunk]].instance()
		add_child(nChunk)
		nChunk.position.y = iChunk * m_iScreenHeight
		
		var nEnemyTileMap: TileMap = nChunk.get_node("EnemyTileMap")
		for iEnemyTileId in range(m_anEnemies.size()):
			for vTilePos in nEnemyTileMap.get_used_cells_by_id(iEnemyTileId):
				nEnemyTileMap.set_cellv(vTilePos, -1)
				var vCellSize: Vector2 = nEnemyTileMap.get_cell_size()
				var nEnemy: Enemy = m_anEnemies[iEnemyTileId].instance()
				add_child(nEnemy)
				nEnemy.position = Vector2(
					vTilePos.x * vCellSize.x * nEnemyTileMap.scale.x,
					vTilePos.y * vCellSize.y * nEnemyTileMap.scale.y + iChunk * m_iScreenHeight)
				nEnemy.scale = nEnemyTileMap.scale
