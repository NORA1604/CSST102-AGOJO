# Nigel Oliver R. Agojo, BSCS 3A

# Weather-Based Outfit Recommender Expert System (with Chained Rule Prioritization)

def outfit_recommender(temperature, rain, snow, wind, occasion):
    suggestions = []
    intermediate = None

    # Track which base suggestions to suppress
    suppress_temp = False
    suppress_wind = False
    suppress_snow = False

    # Temperature Rules
    if temperature < 10:
        suggestions.append("It's cold — Wear a heavy jacket and thermal layers.")
    elif 10 <= temperature < 18:
        intermediate = "light jacket needed"
    elif temperature >= 18:
        intermediate = "It's warm — No jacket needed, light clothing is fine."

    # Chained Rule: Snow + Light Jacket
    if intermediate == "light jacket needed" and snow.lower() == "yes":
        suggestions.append("Snow and cool — Wear a light jacket or hoodie.")
        suppress_temp = True
        suppress_snow = True

    # Chained Rule: Wind + Light Jacket
    elif intermediate == "light jacket needed" and wind.lower() == "light":
        suggestions.append("Mild wind and cool — Wear a light jacket or hoodie.")
        suppress_temp = True
        suppress_wind = True

    # Chained Rule: Warm + Snow
    if intermediate == "It's warm — No jacket needed, light clothing is fine." and snow.lower() == "yes":
        suggestions.append("Contradicting conditions, try again.")
        suppress_temp = True
        suppress_snow = True

    # Rain Rule
    if rain.lower() == "yes":
        suggestions.append("☔ It's rainy — Carry an umbrella and wear waterproof coat and shoes.")

    # Snow Rule
    if snow.lower() == "yes" and not suppress_snow:
        suggestions.append("It's snowing — Wear a warm jacket and gloves.")

    # Wind Rule
    if wind.lower() == "strong" and not suppress_wind:
        suggestions.append("Strong wind — Wear a windbreaker.")

    # Temperature Rule
    if intermediate == "light jacket needed" and not suppress_temp:
        suggestions.append("It's cool — Consider wearing a light jacket.")

    # Occasion Rules
    if occasion.lower() == "formal" and temperature > 10:
        suggestions.append("Formal event — Wear a blazer and dress shoes.")
    elif occasion.lower() == "sports":
        suggestions.append("Sports occasion — Wear athletic wear and suitable shoes.")

    # Fallback
    if not suggestions:
        suggestions.append("No specific rules matched. Dress comfortably for the weather.")

    return suggestions

# User Input
try:
    print("📝 Enter weather conditions below:\n")
    temperature = float(input("Temperature in °C: "))
    rain = input("Is it raining? (yes/no): ")
    snow = input("Is it snowing? (yes/no): ")
    wind = input("Wind level (none/light/strong): ")
    occasion = input("Occasion (casual/formal/sports): ")

    # Run Expert System
    result = outfit_recommender(temperature, rain, snow, wind, occasion)

    # Display Result
    print("\n Outfit Recommendations:")
    for res in result:
        print(f"- {res}")

except Exception as e:
    print("Invalid input. Please try again.")
    print("Error:", e)