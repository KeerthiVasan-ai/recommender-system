def get_recommendations(activity_level):
    if activity_level == 'Low':
        return [
            "Walk for at least 15-30 minutes each day.",
            "Try light exercises like stretching, bodyweight squats, and lunges.",
            "Take short breaks to stand up and move during the day.",
            "Set a small step goal (e.g., 5,000 steps) and gradually increase."
        ]
    elif activity_level == 'Moderate':
        return [
            "Aim for 30-45 minutes of moderate activity, such as brisk walking or cycling.",
            "Incorporate some strength training exercises twice a week.",
            "Take frequent short walks or stretch breaks during the day.",
            "Gradually increase your step goal to 8,000 steps."
        ]
    else:
        return [
            "Aim for at least 45-60 minutes of intense activity, like running or HIIT workouts.",
            "Include a variety of strength training exercises for full-body fitness.",
            "Set goals to challenge yourself, such as increasing reps or weights.",
            "Consider adding flexibility exercises like yoga or Pilates."
        ]
