def recommend_activities(activity_level):
    if activity_level == 'Low':
        return [
            "Walk for at least 15-30 minutes each day.",
            "Try light exercises like stretching, bodyweight squats, and lunges.",
            "Take short breaks to stand up and move during the day.",
            "Set a small step goal (e.g., 5,000 steps) and gradually increase."
        ]
    elif activity_level == 'Moderate':
        return [
            "Incorporate 30-45 minutes of brisk walking, cycling, or swimming 3-4 times a week.",
            "Add high-intensity intervals to your workouts.",
            "Include strength training exercises twice a week.",
            "Aim for 10,000 steps per day and 150 minutes of moderate activity weekly."
        ]
    elif activity_level == 'High':
        return [
            "Try more intense workouts like running, spinning, or HIIT.",
            "Cross-train with yoga, strength training, and cardio.",
            "Work out 4-5 times a week with a mix of moderate and vigorous activities.",
            "Consider personalized plans like resistance training or targeted cardio."
        ]
    elif activity_level == 'Very High':
        return [
            "Include rest and recovery days to prevent burnout.",
            "Try advanced training like plyometrics or endurance activities.",
            "Track detailed performance metrics (e.g., heart rate, VO2 max).",
            "Add flexibility exercises like yoga to prevent injuries and improve mobility."
        ]
    else:
        return ["Activity level not recognized. Please consult a health professional for personalized advice."]