from flask import Flask,request,jsonify
from flask_cors import CORS
import pandas as pd
import warnings
warnings.filterwarnings("ignore")
from src.recommender_system import get_movie_matrix

app = Flask(__name__)
CORS(app)


@app.route("/recommend",methods=['POST'])
def recommend_movie():
    movie = request.json.get("movie")
    print(movie)
    movie_rating = moviemat[movie]
    print(movie_rating)
    similar_movies = moviemat.corrwith(movie_rating)
    corr_starwars = pd.DataFrame(similar_movies, columns =['Correlation'])
    corr_starwars.dropna(inplace = True)

    corr_starwars.sort_values('Correlation', ascending = False).head(10)
    corr_starwars = corr_starwars.join(ratings['num of ratings'])

    new_df = corr_starwars[corr_starwars['num of ratings']>100].sort_values('Correlation', ascending = False).head()
    movies_list = [[index, row['Correlation'], row['num of ratings']] for index, row in new_df.iterrows()]
    print(movies_list)
    return jsonify({"recommended_movie":movies_list}), 200

if __name__ == "__main__":
    moviemat,ratings= get_movie_matrix()
    print(ratings)
    app.run(debug=False)