extends Node



enum Events { ON_UTILISE, ON_LAND, THWAP }
enum Results { DO_SWING, DO_STOMP }
enum Conditions { NONE, IF_BASE, IF_HELD }

# Must be in order: { Events } : { Results } : [ Conditions ]
#
# Example: { Events.ON_UTILISE : { Results.DO_SWING : [ Conditions.IF_BASE ] } }



var items := {
	"stick": {
		"texture" : preload("res://assets/items/stick.png"),
		"attach_point" : Vector2(0, -14),
		"anchor_point" : Vector2(0, 14),
		"gravity" : 6,
		"properties" : { Events.ON_UTILISE : { Results.DO_SWING : [Conditions.IF_HELD, Conditions.IF_BASE] } }
	},
	
	"stone": {
		"texture" : preload("res://assets/items/stone.png"),
		"attach_point" : Vector2(0, -4),
		"anchor_point" : Vector2(0, 0),
		"gravity" : 18,
		"properties" : { Events.ON_LAND : { Results.DO_STOMP : [Conditions.NONE] } }
	}
}
