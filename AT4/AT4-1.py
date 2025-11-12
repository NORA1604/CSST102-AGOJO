def can_fly(animal_name):
    a = animal_name.strip().lower()
    exceptions = {
        "penguin": "Penguins are birds that cannot fly.",
        "ostrich": "Ostriches are birds that cannot fly.",
        "kiwi": "Kiwis are flightless birds.",
    }

    birds = {"sparrow", "eagle", "hawk", "penguin", "ostrich", "kiwi", "raven", "duck", "geese", "crow", "dove"}
    reasoning = []
    reasoning.append(f"Input: '{animal_name}'")

    if a in birds:
        reasoning.append(f"Known fact: '{animal_name}' is a bird.")
        reasoning.append("Default rule: If an animal is a bird, assume it can fly.")
        if a in exceptions:
            reasoning.append(f"Exception found: {exceptions[a]}")
            reasoning.append(f"Conclusion (revised): '{animal_name}' cannot fly.")
            conclusion = False
        else:
            reasoning.append("No exception known. Conclusion: assume it can fly.")
            conclusion = True
    else:
        reasoning.append(f"No knowledge that '{animal_name}' is a bird.")
        reasoning.append("Cannot apply default bird->can fly rule. Need more info.")
        conclusion = None

    for step in reasoning:
        print(step)
    if conclusion is True:
        print(f"FINAL: '{animal_name}' is assumed to be able to fly (default conclusion).")
    elif conclusion is False:
        print(f"FINAL: '{animal_name}' is assumed NOT to be able to fly (exception).")
    else:
        print(f"FINAL: Unknown — insufficient information to conclude flying ability.")

if __name__ == "__main__":
    print("Example 1: 'sparrow'")
    can_fly("sparrow")
    print("\nExample 2: 'penguin'")
    can_fly("penguin")
    print("\nTry your own")
    animal = input("Enter animal name: ")
    can_fly(animal)