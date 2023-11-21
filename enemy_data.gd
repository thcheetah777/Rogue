extends Resource
class_name EnemyData

enum EnemyType {
	BASIC,
	TURRET,
	DASH
}

@export var type = EnemyType.BASIC
@export var position = Vector2.ZERO
