from flask import Flask, render_template, request, redirect, flash, url_for, session
import firebase_admin
from firebase_admin import credentials, auth
from google.oauth2 import service_account
from google.cloud import firestore
from dotenv import load_dotenv
import os

load_dotenv()  # take environment variables from .env.

# Now get values with os.environ.get()
secret_key = os.environ.get('SECRET_KEY')

cred = credentials.Certificate('firebase-auth.json')
firebase_admin.initialize_app(cred)
SERVICE_ACCOUNT_FILE = 'firebase-auth.json'

# Load credentials from the service account file using google-auth
creds = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE)

# Initialize Firestore client with these credentials and project id
db = firestore.Client(credentials=creds, project=creds.project_id)

# Create an instance of the Flask class
app = Flask(__name__)

# Define a route for the root URL that returns a simple message
@app.route('/')
def home():
    return render_template('index.html')
app.secret_key = secret_key 

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # Grab email & password from form instead of idToken
        email = request.form.get('email')
        password = request.form.get('password')

        if not email or not password:
            flash('Email or password missing.')
            return render_template('login.html')

        try:
            user_docs = db.collection('users').where('email', '==', email).limit(1).stream()
            user_data = None
            uid = None
            for doc in user_docs:
                user_data = doc.to_dict()
                uid = doc.id  # Get Firestore document ID as uid

            if user_data:
                role = user_data.get('role', 'Unknown')
                # Set session variables here to mark user authenticated
                session['uid'] = uid
                session['role'] = role
                session['email'] = email
                return redirect(url_for('dashboard', role=role))
            else:
                flash('User record not found.')
                return render_template('login.html')

        except Exception as e:
            flash(f'Login failed: {str(e)}')
            return render_template('login.html')
    return render_template('login.html')



@app.route('/logout')
def logout():
    session.clear()  # clear all session data (log user out)
    return redirect(url_for('login'))  # redirect back to login page

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        name = request.form['name']
        role = request.form['role']
        try:
            user = auth.create_user(email=email, password=password, display_name=name)

            # Save extra info in Firestore under user uid
            db.collection('users').document(user.uid).set({
                'name': name,
                'email': email,
                'role': role
            })

            flash('User created successfully! Please login.')
            return redirect(url_for('login'))
        except Exception as e:
            flash(f'Error creating user: {str(e)}')
            return render_template('register.html')
    return render_template('register.html')


@app.route('/dashboard')
def dashboard():
    if 'uid' not in session:
        flash('Please login first.')
        return redirect(url_for('login'))

    uid = session['uid']

    user_doc = db.collection('users').document(uid).get()
    if not user_doc.exists:
        flash('User record not found.')
        return redirect(url_for('login'))

    user_data = user_doc.to_dict()
    role = user_data.get('role', 'Unknown')
    name = user_data.get('name', 'User')

    return render_template('dashboard.html', role=role, name=name)

# Run the app only if this script is executed directly
if __name__ == '__main__':
    app.run(debug=True)  # debug=True enables debug mode for development
