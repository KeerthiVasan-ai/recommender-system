from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity


def get_similarity(df):
    feature = df["Key Skills"].tolist()
    tfidf = TfidfVectorizer(stop_words="english")
    tfidf_matrix = tfidf.fit_transform(feature)
    similarity = cosine_similarity(tfidf_matrix)
    return similarity