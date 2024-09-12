import math

def sigmoid(x):
    y = 1.0 / (1 + math.exp(-x))  # Calculate the sigmoid of x
    return y

def activate(inputs, weights):
    h = 0
    for x, w in zip(inputs, weights):  # Iterate over inputs and weights together
        h += x * w  # Accumulate the weighted sum
    return sigmoid(h)  # Apply the sigmoid function to the weighted sum

if __name__ == "__main__":  # Added the missing colon here
    inputs = [0.4, 0.3, 0.2]
    weights = [0.4, 0.7, 0.2]  # Fixed the missing comma here
    output = activate(inputs, weights)  # Calculate the output
    print(output)  # Print the output
