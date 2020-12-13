extends Node



enum Events { ON_UTILISE, ON_ALT_UTILISE, ON_LAND, ON_SWING_LEFT, ON_SWING_RIGHT }
enum Results { DO_SWING_LEFT, DO_SWING_RIGHT, DO_STOMP, DO_THWAP_LEFT, DO_THWAP_RIGHT }
enum Conditions { NONE, IF_BASE, IF_HELD, IS_ON_LEFT_WALL, IS_ON_RIGHT_WALL }

# Must be in order: { Events } : { Results } : [ Conditions ]
#
# Example: { Events.ON_UTILISE : { Results.DO_SWING : [ Conditions.IF_BASE ] } }



var items := {
	"stick": {
		"texture" : preload("res://assets/items/stick.png"),
		"attach_point" : Vector2(0, -14),
		"anchor_point" : Vector2(0, 14),
		"gravity" : 6,
		"events" : { Events.ON_UTILISE : { Results.DO_SWING_LEFT : [Conditions.IF_HELD, Conditions.IF_BASE] }, Events.ON_ALT_UTILISE : { Results.DO_SWING_RIGHT : [Conditions.IF_HELD, Conditions.IF_BASE] } },
		"properties" : {}
	},
	
	"stone": {
		"texture" : preload("res://assets/items/stone.png"),
		"attach_point" : Vector2(0, -4),
		"anchor_point" : Vector2(0, 0),
		"gravity" : 18,
		"events" : { Events.ON_LAND : { Results.DO_STOMP : [Conditions.NONE] }, Events.ON_SWING_LEFT : { Results.DO_THWAP_LEFT : [Conditions.IS_ON_LEFT_WALL] }, Events.ON_SWING_RIGHT : { Results.DO_THWAP_RIGHT : [Conditions.IS_ON_RIGHT_WALL] } },
		"properties" : {}
	}
}
