from flask import Flask, request, jsonify
import joblib
import numpy as np
import pandas as pd
from flask_cors import CORS

from utility.recommedation import recommend_activities
from utility.preprocess import return_preprocess_instance

model = joblib.load('models/model-V1')
app = Flask(__name__)
CORS(app)
encoder, scaler = return_preprocess_instance()

@app.route('/recommend', methods=['POST'])
def recommend():
    data = request.get_json()

    distance = data.get('distance', 0)
    active_minutes = data.get('active_minutes', 0)
    calories = data.get('calories', 0)
    
    print(distance)

    features = ['Total_Distance', 'Very_Active_Minutes', 'Calories_Burned']
    user_input = pd.DataFrame([[distance, active_minutes, calories]], columns=features)
    new_user_input_scaled = scaler.transform(user_input)

    predicted_activity_level = model.predict(new_user_input_scaled)
    activity_level = encoder.inverse_transform(predicted_activity_level)
    
    print(activity_level)

    recommendations = recommend_activities(activity_level[0])
    
    response = {
        'activity_level': activity_level.tolist(),
        'recommendations': recommendations
    }
    
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
