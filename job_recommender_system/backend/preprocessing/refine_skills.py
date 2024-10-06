def format_skills(job):
    skills = job['Key Skills'].split('|')
    formatted_skills = [skill.strip().capitalize() for skill in skills]
    
    job['Key Skills'] = ', '.join(formatted_skills)
    
    return job