# CS6310 Project Group 57 - A6

* Esteban Amas
* Jeffery Gardner
* Kimti Khan
* Tao Li
* Abrar Ul Farhan Mohammed


## Getting started

Make sure you have git installed on your machine (or follow [these instructions](https://www.atlassian.com/git/tutorials/install-git) to install it)

```bash
# Clone this repository and change directories to the cloned repo
git clone https://github.gatech.edu/eamas3/cs6310_assignment_6
cd cs6310_assignment_6

# Install depedencies
npm install --prefix ./web/frontend/

# Build and start containers
docker-compose up -d --build

# Start the frontend dev server
docker-compose exec web npm start --prefix ./frontend/

# _IN A SEPARATE WINDOW_ Setup the database
docker-compose run web ./scripts/docker/do setup

# Create test auth groups (read-only and read/write)
docker-compose run web python manage.py loaddata test_data/auth-groups.json

# Create test users (sysadmin, analyst, and regular)
docker-compose run web python manage.py loaddata test_data/auth-users.json

# (optional) load some test data
# contains: demographic groups, streaming services, studios, and events. no offers.
docker-compose run web python manage.py loaddata test_data/backend-data.json

# (optional) drop all data in the DB but don't destroy the schema
docker-compose run web python manage.py flush

# (optional) to backup DB data (and exclude tables that don't transfer to fresh DBs very well)
docker-compose run web ./scripts/docker/do dumpdata --exclude auth.permission --exclude contenttypes > test_data/db.json

```

## Architecture

1. React (v17.x) for the frontend, Django (v3.x) for the backend (acts like an API), Postgres as the database. Frontend and Backend run in the same container called `web` and the database runs separately in `db`.

## Source Code 

### Frontend 

#### Runtime and Development Dependencies

```json
"axios": "^0.19.2",
"bootstrap": "^4.6.0",
"chart.js": "2.9",
"jwt-decode": "^3.1.2",
"react": "^17.0.2",
"react-bootstrap": "^1.5.2",
"react-chartjs-2": "^2.11.1",
"react-dom": "^17.0.2",
"react-json-to-csv": "^1.0.4",
"react-router-dom": "^5.2.0",
"react-scripts": "3.4.1"
```

### Backend

#### Runtime Dependencies

```python
asgiref==3.3.4
Django==3.0.8
django-cors-headers==3.4.0
djangorestframework==3.12.4
djangorestframework-simplejwt==4.6.0
psycopg2-binary==2.8.6
PyJWT==2.0.1
pytz==2021.1
sqlparse==0.4.1
```

The following links are for documentation, articles, and blog posts that were useful in configuring this full-stack web application:

* https://docs.djangoproject.com/en/3.2/topics/auth/customizing/
* https://jwt.io/
* https://adriennedomingus.com/blog/djangos-autonow-and-autonowadd-fields-for-auditing-creation-and-modification-timestamps
* https://realpython.com/customize-django-admin-python/#setting-up-the-django-admin
* https://docs.djangoproject.com/en/3.1/topics/db/models/#relationships
