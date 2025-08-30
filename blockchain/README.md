# Deploying GreenHydrogenCertificate Smart Contract with Foundry

We’ll use Foundry (a powerful Ethereum development toolkit) to deploy the contract on the Ethereum Sepolia testnet using MetaMask private key + Infura RPC.


✅ Prerequisites
- MetaMask installed with some Sepolia ETH (testnet tokens).
- Git Bash installed (on Windows).
- An Infura account (free) → to get your RPC endpoint.  
  👉 [MetaMask Developer Endpoints](https://developer.metamask.io/key/active-endpoints)

1. Install Foundry
Open Git Bash and run:

bash
# Download Foundry installer
curl -L https://foundry.paradigm.xyz | bash

# Reload shell
source /c/Users/HP\ Laptop/.bashrc

# Install Foundry binaries
foundryup


✅ Verify installation:

forge --version
cast --version
anvil --version

2. Initialize Project
Navigate to your project folder and create a Foundry project:
forge init green-hydrogen-smart-contract
cd green-hydrogen-smart-contract

This generates:

green-hydrogen-smart-contract/
├── src/
├── lib/
├── script/
├── test/
└── foundry.toml

3. Add Your Contract
Paste your GreenHydrogenCertificate.sol contract inside:
src/GreenHydrogenCertificate.sol

4. Create Deployment Script
Create a file:
script/Deploy.s.sol


Paste this code:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/GreenHydrogenCertificate.sol";

contract DeployGreenHydrogenCertificate is Script {
    function run() external {
        vm.startBroadcast();
        GreenHydrogenCertificate cert = new GreenHydrogenCertificate();
        vm.stopBroadcast();
    }
}

5. Setup Environment Variables
Create a .env file in your project root:
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID
PRIVATE_KEY=your_metamask_private_key

⚠ Never share your private key. Only use testnet accounts here.

6. Deploy the Contract
Run this command in Git Bash:
forge script script/Deploy.s.sol:DeployGreenHydrogenCertificate \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast


✅ After execution, you’ll see:
ONCHAIN EXECUTION COMPLETE & SUCCESSFUL
and a contract address.

7. Verify on Etherscan
Go to Sepolia Etherscan
Paste your contract address.
You’ll see your deployed contract 🎉
