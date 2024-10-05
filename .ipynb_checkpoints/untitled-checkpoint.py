# Import the Path class from the pathlib module
from pathlib import Path

# Create a Path object for the directory 'samples'
path = Path('all-samples-wav')

# Initialize an empty list to hold the file paths
files = []

# Check if the path exists and if it's a directory
if path.exists() and path.is_dir():
    # Use a list comprehension with rglob() to gather all .wav files (recursively)
    # and store them in the 'files' list
    files = [file for file in path.rglob('*.wav')]

    # Check how many files were in the directory
    print(f"found {len(files)} audio files in '{path}' folder.")

# If the path doesn't exist or isn't a directory, print a message
else:
    print("'all-samples-wav' directory does not exist.")



    