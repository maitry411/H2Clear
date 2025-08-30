Private key can be found in the metamask chrome extension account details.
and the rpc url at: https://developer.metamask.io/key/active-endpoints
We have deployed this on ethereum using foundry.
For foundry you first need GIT BASH

Foundry installer download:
curl -L https://foundry.paradigm.xyz | bash
Reload your shell:
source /c/Users/HP\ Laptop/.bashrc
Install Foundry:
foundryup
Verify:
forge --version
cast --version
anvil --version

Navigate to the Project Directory
then Initialize Foundry Project:
forge init
This will create a basic project structure:
green-hydrogen-smart-contract/
├── src/
├── lib/
├── script/
├── test/
└── foundry.toml
And some more things we don't need to think of.

Open src/GreenHydrogenCertificate.sol.

Add your contract code into this file:

Create script/Deploy.s.sol and paste the following code:
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
Then, create a .env file and add the following:

SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID
PRIVATE_KEY=your_metamask_private_key

Deploy Your Contract
forge script script/Deploy.s.sol:DeployGreenHydrogenCertificate \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast

You'll get a lot in result when you follow these successfully.
Along with: ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

Verify the Contract on Etherscan:

Go to Sepolia Etherscan
 and paste the contract address:

 That's how we successfully deployed our blockchain smart contract.
