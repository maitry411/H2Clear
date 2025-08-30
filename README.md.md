# 🌍 Green Hydrogen Certificate System
[`Link To Entry Point`](https://h2-clear-landing-page.vercel.app/)

This repository implements a **blockchain-powered system** for tracking and managing **Green Hydrogen Certificates (GHCs)**.  

It is divided into **four** main parts:

## 📂 Project Structure
    ├── blockchain/ # Smart contracts (Solidity)
    ├── backend/ # Backend APIs (FastAPI + Web3.py)
    ├── frontend/ # User interface (Flutter)
    ├── landing-page/ # Public landing page (Static site)

## ⚡ Components

### 1. Blockchain (`/blockchain`)
- Implements the **GreenHydrogenCertificate** smart contract in Solidity.
- Deployed on Ethereum-compatible blockchains.
- Handles role management, issuance, transfer, and retirement of certificates.

👉 See [`/blockchain/README.md`](./blockchain/README.md) for full details.


### 2. Backend (`/backend`)
- Built with **FastAPI** + **Web3.py**.
- Connects the frontend to the blockchain.
- Provides REST APIs for role management, certificate issuance, transfer, and retirement.

👉 See [`/backend/README.md`](./backend/README.md) for setup instructions.


### 3. Frontend (`/frontend`)
- Built with **Flutter**.
- User-friendly interface for producers, certifiers, buyers, and regulators.
- Interacts with the backend to perform blockchain actions.

👉 See [`/frontend/README.md`](./frontend/README.md) for running the app.

### 4. Landing Page (`/landing-page`)
- A static, **public-facing website** that explains the project, benefits of green hydrogen, and how the system works.
- Can be deployed on platforms like Vercel, Netlify, or GitHub Pages.
- Does not interact directly with the blockchain; meant for outreach and education.

👉 See [`/landing-page/README.md`](./landing-page/README.md) for deployment instructions.

## 🚀 How to Run

Each folder contains its own README with setup instructions.
Although we will be deploying the entire application.
Entry Point URL:-

Progress so far:
✅Block Chain Deployed
✅Landing Page Deployed.

Basic flow:

1. Deploy the smart contract (`/blockchain`).
2. Run the FastAPI backend (`/backend`).
3. Start the Flutter frontend (`/frontend`).
4. Just view the landing page its simple html css.
