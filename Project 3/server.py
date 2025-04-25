from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="oop project 2"
)
cursor = db.cursor()

def get_all_job_listings():
    cursor.execute("SELECT * FROM finished")
    job_listings = cursor.fetchall()
    return job_listings

def refine_job_search_results(search_criteria):
    refined_results = []
    for row in get_all_job_listings():
        if search_criteria['title'] and search_criteria['title'].lower() not in row[0].lower():
            continue
        if search_criteria['company'] and search_criteria['company'].lower() not in row[1].lower():
            continue
        if search_criteria['location'] and search_criteria['location'].lower() not in row[2].lower():
            continue
        refined_results.append(row)
    return refined_results

def clean_location(location):
    parts = [part.strip() for part in location.replace('\n', ',').split(',')]
    cleaned_parts = [part.replace('Co ', '').strip() for part in parts if part.strip()]
    return cleaned_parts[-1] if cleaned_parts else None

def location_with_count():
    location_counts = {}
    for row in get_all_job_listings():
        location = row[2]
        cleaned_location = clean_location(location)
        if cleaned_location:
            location_counts[cleaned_location] = location_counts.get(cleaned_location, 0) + 1
    return location_counts

def company_with_count():
    company_counts = {}
    for row in get_all_job_listings():
        company = row[1]
        company_counts[company] = company_counts.get(company, 0) + 1
    return company_counts



@app.route('/')
def home():
    return render_template('home.html')

@app.route('/alljobs')
def index():
    job_listings = get_all_job_listings()
    return render_template('all_jobs.html', job_listings=job_listings)

@app.route('/jobsearch', methods=['GET', 'POST'])
def search_job_listings():
    search_criteria = {}
    refined_results = []

    if request.method == 'POST':
        search_criteria = {
            'location': request.form.get('location'),
            'salary': request.form.get('salary'),
            'company': request.form.get('company'),
            'title': request.form.get('title')
        }
        refined_results = refine_job_search_results(search_criteria)

    return render_template('jobsearch.html', search_criteria=search_criteria, refined_results=refined_results)

@app.route('/job_counts_table')
def display_job_counts_table():
    job_counts = location_with_count()
    return render_template('locationcounts.html', job_counts=job_counts)

@app.route('/job_counts_chart')
def display_job_counts_chart():
    job_counts = location_with_count()
    locations = list(job_counts.keys())
    counts = list(job_counts.values())
    return render_template('locationcharts.html', locations=locations, counts=counts)

@app.route('/company_counts_table')
def display_company_counts_table():
    company_counts = company_with_count()
    return render_template('companycounts.html', company_counts=company_counts)

@app.route('/company_counts_chart')
def display_company_counts_chart():
    company_counts = company_with_count()
    companies = [c for c in company_counts if c is not None and company_counts[c] is not None]
    counts = [company_counts[c] for c in companies]
    return render_template('companycharts.html', companies=companies, counts=counts)

def create_clean_salary_column():
    cursor.execute("ALTER TABLE finished ADD COLUMN clean_salary FLOAT")

def clean_salary():
    cursor.execute("UPDATE finished SET clean_salary = NULLIF(REPLACE(salary, 'Salary not specified', ''), '')")

def fetch_salary_statistics(cursor):
    cursor.execute("SELECT COUNT(clean_salary) FROM finished WHERE clean_salary IS NOT NULL")
    total_count = cursor.fetchone()[0]

    cursor.execute("SELECT AVG(clean_salary) FROM finished WHERE clean_salary IS NOT NULL")
    average_salary = cursor.fetchone()[0]

    cursor.execute("SELECT MIN(clean_salary) FROM finished WHERE clean_salary IS NOT NULL")
    min_salary = cursor.fetchone()[0]

    cursor.execute("SELECT MAX(clean_salary) FROM finished WHERE clean_salary IS NOT NULL")
    max_salary = cursor.fetchone()[0]

    return total_count, average_salary, min_salary, max_salary

@app.route('/stats')
def display_stats():
    total_count, average_salary, min_salary, max_salary = fetch_salary_statistics(cursor)
    return render_template('stats.html', total_count=total_count, average_salary=average_salary, min_salary=min_salary, max_salary=max_salary)

if __name__ == '__main__':
    app.run(debug=True, port=5000)