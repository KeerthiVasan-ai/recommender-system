from preprocessing.refine_skills import format_skills


def jobs_recommendation(df,indices,title,similarity):
    if title not in indices:
        print(f"Error: The title '{title}' does not exist in the dataset.")
        return None
    
    index = indices[title]
    similarity_scores = list(enumerate(similarity[index]))
    similarity_scores = sorted(similarity_scores, key=lambda x: x[1], reverse=True)
    similarity_scores = similarity_scores[1:6]
    newsindices = [i[0] for i in similarity_scores]
    
    recommended_jobs = df[['Job Title', 'Job Experience Required', 'Key Skills']].iloc[newsindices]
    recommended_jobs_dict = recommended_jobs.to_dict(orient="records")

    formatted_jobs = [format_skills(job) for job in recommended_jobs_dict]

    return formatted_jobs