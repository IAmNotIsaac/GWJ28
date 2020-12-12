extends Node



func merge_dictionaries(a : Dictionary, b : Dictionary) -> Dictionary:
	var result : Dictionary
	
	result = a
	
	for i in len(b):
		var key = b.keys()[i]
		var value = b.values()[i]
		
		a[key] = value
	
	return result
