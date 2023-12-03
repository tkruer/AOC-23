import random
import datetime

languages = [
    'Python', 'Java', 'C++', 'C#', 'JavaScript', 'Ruby', 
    'PHP', 'C', 'Swift', 'Go', 'Objective-C', 'Mojo', 'Cuda',
    'Kotlin', 'Scala', 'Rust', 'Groovy', 'Dart', 'Haskell', 
    'Lua', 'Julia', 'Elixir', 'Clojure',  'Erlang', 'OCaml', 
    'TypeScript', 
]

print(f"Today for {datetime.datetime.now().today().strftime('%m/%d')} you're doing AOC in {random.choice(languages)}. Good luck!")