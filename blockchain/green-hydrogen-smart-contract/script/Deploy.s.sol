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
