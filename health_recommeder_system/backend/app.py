from flask import Flask, request, jsonify
import joblib
import numpy as np
from flask_cors import CORS

from utility.recommedation import get_recommendations

model = joblib.load('models/model-V1')
app = Flask(__name__)
CORS(app)

@app.route('/recommend', methods=['POST'])
def recommend():
    data = request.get_json()

    distance = data.get('distance', 0)
    active_minutes = data.get('active_minutes', 0)
    calories = data.get('calories', 0)
    
    user_input = np.array([[distance, active_minutes, calories]])
    
    activity_level = model.predict(user_input)[0]
    
    if isinstance(activity_level, np.int32):
        activity_level = int(activity_level)
    
    recommendations = get_recommendations(activity_level)
    
    response = {
        'activity_level': activity_level,
        'recommendations': recommendations
    }
    
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
