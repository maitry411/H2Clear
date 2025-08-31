import { initializeApp } from "https://www.gstatic.com/firebasejs/10.9.0/firebase-app.js";
import { getAuth, 
         GoogleAuthProvider } from "https://www.gstatic.com/firebasejs/10.9.0/firebase-auth.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/10.9.0/firebase-firestore.js";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyACFElNciBDDXlYq1BrJE0OhH_uTmM9UPI",
  authDomain: "h2clear-40f73.firebaseapp.com",
  projectId: "h2clear-40f73",
  storageBucket: "h2clear-40f73.firebasestorage.app",
  messagingSenderId: "722644848903",
  appId: "1:722644848903:web:ddf1953c98e7bdff3a75a2",
  measurementId: "G-TYDRN2PXXW"
};
  // Initialize Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const provider = new GoogleAuthProvider();

const db = getFirestore(app);

export { auth, provider, db };