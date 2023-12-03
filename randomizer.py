import random
import datetime
import json

with open("languages.json", "r") as f:
    data = json.load(f)

# Choose a random language and remove it from possible_languages
selected_language = random.choice(data['possible_languages'])
data['possible_languages'].remove(selected_language)

# Add the selected language to completed_languages
data['completed_languages'].append(selected_language)

# Update the JSON file
with open("languages.json", "w") as f:
    json.dump(data, f, indent=4)

print(f"Today for {datetime.datetime.now().today().strftime('%m/%d')} you're doing AOC in {selected_language}. Good luck!")
