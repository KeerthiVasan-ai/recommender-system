from flask import Flask,request,jsonify
from flask_cors import CORS
import pandas as pd
from utility.core import get_similarity
from utility.recommendation import jobs_recommendation

app = Flask(__name__)
CORS(app)

df = pd.read_csv("dataset/jobs.csv")
similarity = get_similarity(df)
indices = pd.Series(df.index, index=df['Job Title']).to_dict()


@app.route("/recommend",methods=["POST"])
def get_recommendation():
    data = request.get_json()

    title = data.get('title', "")

    jobs = jobs_recommendation(df=df,indices=indices,title=title,similarity=similarity)
    print(jobs)

    return jsonify(jobs)

if __name__ == "__main__":
    app.run(debug=True)