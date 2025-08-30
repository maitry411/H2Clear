// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GreenHydrogenCertificate {
    // Define roles
    address public owner;
    mapping(address => bool) public certifiers;
    mapping(address => bool) public producers;
    mapping(address => bool) public buyers;
    mapping(address => bool) public regulators;

    // Token balances mapping (tokens = certificates)
    mapping(address => uint256) private balances;
    mapping(address => uint256) private retiredBalances;

    // Events for transparency
    event Issued(address indexed producer, uint256 amount);
    event Transferred(address indexed from, address indexed to, uint256 amount);
    event Retired(address indexed holder, uint256 amount);

    // Modifiers for role restriction
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyCertifier() {
        require(certifiers[msg.sender], "Only certifier allowed");
        _;
    }

    modifier onlyProducer() {
        require(producers[msg.sender], "Only producer allowed");
        _;
    }

    modifier onlyBuyer() {
        require(buyers[msg.sender], "Only buyer allowed");
        _;
    }

    modifier onlyRegulator() {
        require(regulators[msg.sender], "Only regulator allowed");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCertifier(address _certifier) external onlyOwner {
        certifiers[_certifier] = true;
    }

    function removeCertifier(address _certifier) external onlyOwner {
        certifiers[_certifier] = false;
    }

    function addProducer(address _producer) external onlyOwner {
        producers[_producer] = true;
    }

    function removeProducer(address _producer) external onlyOwner {
        producers[_producer] = false;
    }

    function addBuyer(address _buyer) external onlyOwner {
        buyers[_buyer] = true;
    }

    function removeBuyer(address _buyer) external onlyOwner {
        buyers[_buyer] = false;
    }

    function addRegulator(address _regulator) external onlyOwner {
        regulators[_regulator] = true;
    }

    function removeRegulator(address _regulator) external onlyOwner {
        regulators[_regulator] = false;
    }
    function issueCertificate(address _producer, uint256 _amount) external onlyCertifier {
        require(producers[_producer], "Address is not a registered producer");
        require(_amount > 0, "Amount must be greater than zero");

        balances[_producer] += _amount;

        emit Issued(_producer, _amount);
    }
    function transferCertificate(address _to, uint256 _amount) external onlyProducer {
        require(buyers[_to], "Recipient not registered as buyer");
        require(balances[msg.sender] >= _amount, "Insufficient certificate balance");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transferred(msg.sender, _to, _amount);
    }
    function retireCertificate(uint256 _amount) external onlyBuyer {
        require(balances[msg.sender] >= _amount, "Not enough certificates to retire");

        balances[msg.sender] -= _amount;
        retiredBalances[msg.sender] += _amount;

        emit Retired(msg.sender, _amount);
    }
    function balanceOf(address _user) external view returns (uint256) {
        return balances[_user];
    }

    function retiredBalanceOf(address _user) external view returns (uint256) {
        return retiredBalances[_user];
    }

}
