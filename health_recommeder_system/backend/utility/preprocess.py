from sklearn.preprocessing import StandardScaler,LabelEncoder
import pandas as pd
from sklearn.model_selection import train_test_split

def return_preprocess_instance():
    data = pd.read_csv('D:\\recommender-system\\health_recommeder_system\\dataset\\fitness_activity.csv')
    encoder = get_encoder_instance(data)
    scaler = get_scaler_instance(data)
    return encoder,scaler

def get_encoder_instance(data):
    label_encoder = LabelEncoder()
    data['Activity_Level'] = pd.cut(data['Very_Active_Minutes'], bins=[0, 30, 60, 120, 9999],
                                labels=['Low', 'Moderate', 'High', 'Very High'])
    data['Activity_Level_Encoded'] = label_encoder.fit_transform(data['Activity_Level'])

    return label_encoder


def get_scaler_instance(data):
    scaler = StandardScaler()

    features = ['Total_Distance', 'Very_Active_Minutes', 'Calories_Burned']
    X = data[features]
    y = data['Activity_Level_Encoded']

    X_train,_,_,_ = train_test_split(X, y, test_size=0.2, random_state=42)
    X_train = scaler.fit_transform(X_train)

    return scaler
