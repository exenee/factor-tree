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
		$Factors.text = "Factors: Cannot factor any decimal number, or number is way too large!"
	elif float($Number.text) > 999999999999999:
		$Factors.text = "Factors: Number too big to process!"
	else:
		$Factors.text = "Factors: " + str(get_factors(int($Number.text)))
		$Factors.text = $Factors.text.replace("[", "").replace("]", "")
		
	#######################
	# Prime Factorization #
	#######################
	
	if float($Number.text) == 0:
		$"Prime Factorization".text = "Prime Factorization: Zero has no factors!"
	elif float($Number.text) != int($Number.text): # evil "if has decimal" hack
		$"Prime Factorization".text = "Prime Factorization: Cannot factor any decimal number, or number is way too large!"
	elif float($Number.text) > 999999999999999:
		$"Prime Factorization".text = "Prime Factorization: Number too big to process!"
	else:
		$"Prime Factorization".text = "Prime Factorization: " + str(format_factors(get_prime_factorization(int($Number.text))))
		$"Prime Factorization".text = $"Prime Factorization".text.replace("[", "").replace("]", "")
	
	#######################
	#     Square Root     #
	#######################
	
	if int($Number.text) < 0:
		$"Square Root".text = "Square Root: Cannot get square root of non-zero negative number"
	else:
		$"Square Root".text = "Square Root: " + str(format_square_root(float($Number.text)))
		# Temporary, replace with more 
		# readable representation later
	
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
	
func get_prime_factorization(n: int) -> Array:
	#######################
	#Get Pr. Factorization#
	#######################
	var factors = []
	var divisor = 2
	
	# Loop until n becomes 1
	while n > 1:
		# Check if divisor divides n
		while n % divisor == 0:
			factors.append(divisor)
			n /= divisor
		divisor += 1

	return factors

func format_factors(factors: Array) -> String:
	var result: String
	#######################
	#    Format Factors   #
	#######################
	if factors.size() <= 1:
		result = str(factors[0])
	else:
		result = str(factors[0])  # Start with the first element
	
	# Iterate over the rest of the array (starting from the second element)
	for i in range(1, factors.size()):
		result += "x" + str(factors[i])  # Add 'x' between elements
		
	return result
	
func format_square_root(value: float) -> String:
	#######################
	#    Format SqRoot    #
	#######################
	# Get the square root of the number
	var root_value = sqrt(value)
	
	# Try to simplify the square root by checking for square factors
	var factor = 1
	var remaining_value = value
	
	# Find the largest square factor (factorized form)
	for i in range(2, int(remaining_value ** 0.5) + 1):
		if int(remaining_value) % (i * i) == 0:  # Ensure we're using integer modulus
			factor = i
			remaining_value /= (i * i)
	
	# Now format the string based on whether there was a simplification
	if factor == 1:
		return "√" + str(value)  # If no simplification, just display √value
	else:
		if remaining_value == 1:
			return str(factor) + "√1"  # Handle the case for perfect squares like 4
		else:
			return str(factor) + "√" + str(int(remaining_value))  # Otherwise display factor√remaining_value
