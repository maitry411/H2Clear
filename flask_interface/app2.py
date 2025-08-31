from flask import Flask, request, jsonify
import pyrebase
from supabase import create_client, Client

app = Flask(__name__)

# Firebase config
firebaseConfig = {
    apiKey: "AIzaSyACFElNciBDDXlYq1BrJE0OhH_uTmM9UPI",
  authDomain: "h2clear-40f73.firebaseapp.com",
  projectId: "h2clear-40f73",
  storageBucket: "h2clear-40f73.firebasestorage.app",
  messagingSenderId: "722644848903",
  appId: "1:722644848903:web:ddf1953c98e7bdff3a75a2",
  measurementId: "G-TYDRN2PXXW"
}

firebase = pyrebase.initialize_app(firebaseConfig)
auth = firebase.auth()

# Supabase client init
SUPABASE_URL = "https://xyzcompany.supabase.co"
SUPABASE_KEY = "public-anon-key"
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.route('/signup', methods=['POST'])
def signup():
    data = request.json
    email = data['email']
    password = data['password']
    role = data.get('role', 'user')  # default role
    
    # Create user in Firebase
    user = auth.create_user_with_email_and_password(email, password)
    uid = user['localId']

    # Store user data & role in Supabase PostgreSQL
    supabase.table('users').insert({
        'uid': uid,
        'email': email,
        'role': role
    }).execute()

    return jsonify({"message": "User created", "uid": uid}), 201

if __name__ == '__main__':
    app.run(debug=True)
