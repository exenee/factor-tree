extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	#######################
	#       Factors       #
	#######################
	if float($Number.text) == 0:
		$Factors.text = "Factors: Zero has no factors!"
	elif float($Number.text) != int($Number.text): # evil "if has decimal" hack
		$Factors.text = "Factors: Cannot factor any decimal number!"
	else:
		$Factors.text = "Factors: " + str(get_factors(int($Number.text)))
		$Factors.text = $Factors.text.replace("[", "").replace("]", "")
		
	#######################
	# Prime Factorization #
	#######################
	
	print("Prime Factorization not yet implemented!")
	
	#######################
	#     Square Root     #
	#######################
	
	if int($Number.text) < 0:
		$"Square Root".text = "Square Root: Cannot get square root of non-zero negative number"
	else:
		$"Square Root".text = "Square Root: " + str(sqrt(float($Number.text))) # Temporary
	
func get_factors(number: int) -> Array:
	#######################
	#     Get Factors     #
	#######################
	var factors = []
	
	# Use absolute value of number for factorization
	var abs_number = abs(number)
	
	# Iterate from 1 to the square root of the absolute number
	for i in range(1, int(sqrt(abs_number)) + 1):
		if abs_number % i == 0:
			factors.append(i)  # Add the positive divisor
			if i != abs_number / i:
				factors.append(abs_number / i)  # Add the corresponding paired positive factor

	# If the original number was negative, add the negative counterparts of all factors
	if number < 0:
		var negative_factors = []
		for factor in factors:
			negative_factors.append(-factor)
		factors += negative_factors
	
	factors.sort()
	return factors
