extends Node



enum Events { ON_UTILISE, ON_ALT_UTILISE, ON_LAND, ON_SWING_LEFT, ON_SWING_RIGHT }
enum Results { DO_SWING_LEFT, DO_SWING_RIGHT, DO_THWAP, DO_FLAME, SPAWN_ITEM, DELETE_MYSELF }
enum Conditions { NONE, IF_BASE, IF_HELD, IS_COLLIDING }

# Must be in order: { Events } : { Results } : [ Conditions ]
#
# Example: { Events.ON_UTILISE : { Results.DO_SWING : [ Conditions.IF_BASE ] } }



var items := {
	"stick" : {
		"texture" : preload("res://assets/items/stick.png"),
		"gravity" : 6,
		"events" : { Events.ON_UTILISE : { Results.DO_SWING_LEFT : [Conditions.IF_HELD, Conditions.IF_BASE] }, Events.ON_ALT_UTILISE : { Results.DO_SWING_RIGHT : [Conditions.IF_HELD, Conditions.IF_BASE] } },
		"properties" : {}
	},
	
	"stone" : {
		"texture" : preload("res://assets/items/stone.png"),
		"gravity" : 18,
		"events" : { Events.ON_LAND : { Results.DO_THWAP : [Conditions.IF_BASE] }, Events.ON_SWING_LEFT : { Results.DO_THWAP : [Conditions.IS_COLLIDING] }, Events.ON_SWING_RIGHT : { Results.DO_THWAP : [Conditions.IS_COLLIDING] } },
		"properties" : {}
	},
	
	"egg" : {
		"texture" : preload("res://assets/items/egg.png"),
		"gravity" : 10,
		"events" : {},
		"properties" : {}
	},
	
	"egg_cracked" : {
		"texture" : preload("res://assets/items/egg_crack.png"),
		"gravity" : 12,
		"events" : {},
		"properties" : {}
	},
	
	"egg_uncooked" : {
		"texture" : preload("res://assets/items/egg_uncooked.png"),
		"attach_point" : Vector2(0, -4),
		"anchor_point" : Vector2(0, 0),
		"gravity" : 4,
		"events" : {},
		"properties" : {}
	},
	
	"egg_cooked" : {
		"texture" : preload("res://assets/items/egg_cooked.png"),
		"gravity" : 4,
		"events" : {},
		"properties" : {}
	},
	
	"bread" : {
		"texture" : preload("res://assets/items/bread.png"),
		"gravity" : 4,
		"events" : {},
		"properties" : {}
	},
	
	"lighter" : {
		"texture" : preload("res://assets/items/lighter.png"),
		"gravity" : 6,
		"events" : { Events.ON_UTILISE : { Results.DO_FLAME : [ Conditions.IF_HELD ] } },
		"properties" : {}
	}
}
