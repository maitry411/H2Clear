// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GreenHydrogenCertificate is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address public owner;
    mapping(address => bool) public certifiers;
    mapping(address => bool) public producers;
    mapping(address => bool) public buyers;
    mapping(address => bool) public regulators;

    mapping(uint256 => bool) private retired; // tokenId → retired?

    event Issued(address indexed producer, uint256 tokenId);
    event Transferred(address indexed from, address indexed to, uint256 tokenId);
    event Retired(address indexed holder, uint256 tokenId);

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

    constructor() ERC721("GreenHydrogenCertificate", "GHC") {
        owner = msg.sender;
    }

    // --- role management ---
    function addCertifier(address _certifier) external onlyOwner { certifiers[_certifier] = true; }
    function removeCertifier(address _certifier) external onlyOwner { certifiers[_certifier] = false; }
    function addProducer(address _producer) external onlyOwner { producers[_producer] = true; }
    function removeProducer(address _producer) external onlyOwner { producers[_producer] = false; }
    function addBuyer(address _buyer) external onlyOwner { buyers[_buyer] = true; }
    function removeBuyer(address _buyer) external onlyOwner { buyers[_buyer] = false; }
    function addRegulator(address _regulator) external onlyOwner { regulators[_regulator] = true; }
    function removeRegulator(address _regulator) external onlyOwner { regulators[_regulator] = false; }

    // --- core logic ---
    function issueCertificate(address _producer, string memory _tokenURI) 
        external onlyCertifier 
    {
        require(producers[_producer], "Address is not a registered producer");

        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(_producer, newTokenId);
        _setTokenURI(newTokenId, _tokenURI);

        emit Issued(_producer, newTokenId);
    }

    function transferCertificate(address _to, uint256 _tokenId) external onlyProducer {
        require(buyers[_to], "Recipient not registered as buyer");
        require(ownerOf(_tokenId) == msg.sender, "You don't own this certificate");

        _transfer(msg.sender, _to, _tokenId);

        emit Transferred(msg.sender, _to, _tokenId);
    }

    function retireCertificate(uint256 _tokenId) external onlyBuyer {
        require(ownerOf(_tokenId) == msg.sender, "You don't own this certificate");
        require(!retired[_tokenId], "Already retired");

        retired[_tokenId] = true;
        // _burn(_tokenId); // <-- decide whether to burn or keep

        emit Retired(msg.sender, _tokenId);
    }

    function isRetired(uint256 _tokenId) external view returns (bool) {
        return retired[_tokenId];
    }
}
