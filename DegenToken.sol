// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    
    event ClassRedeemed(address indexed user, uint256 classId, string className, uint256 amount);

    // Mapping of class IDs to their token values
    mapping(uint256 => uint256) public classPrices;

    // Mapping to track player's classes
    mapping(address => mapping(uint256 => bool)) public playerClasses; // playerClasses[playerAddress][classId] = true/false

    // Constructor
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        // Initialize class prices
        classPrices[1] = 1500;    
        classPrices[2] = 1500;    
        classPrices[3] = 1000;    
        classPrices[4] = 1000;     
        classPrices[5] = 2500;    
        classPrices[6] = 2500;    
        classPrices[7] = 5000;   
        classPrices[8] = 5000;    
        classPrices[9] = 10000;    
        classPrices[10] = 10000;   
    }

    // Mint function for the owner to mint new tokens
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Burn tokens function
    function burn(uint256 amount) public {
        require(balanceOf(msg.sender)>= amount, "Sorry, you do not have enough balance!"); 
        _burn(_msgSender(), amount);
    }

    // Transfer tokens function
    function transferTokens(address to, uint256 amount) external {
        _transfer(msg.sender, to, amount);
    }

    // Redeem tokens for a class
    function redeemClass(uint256 classId) external {
        uint256 classPrice = classPrices[classId];
        require(classPrice > 0, "Invalid class ID!");
        require(balanceOf(msg.sender) >= classPrice, "Sorry, insufficient tokens!");
        require(!playerClasses[msg.sender][classId], "You already have this class!");

        // Burn the tokens
        _burn(msg.sender, classPrice);

        // Grant the class to the player
        playerClasses[msg.sender][classId] = true;

        // Emit class redeemed event
        emit ClassRedeemed(msg.sender, classId, getClassName(classId), classPrice);
    }

    // Get the name of a class based on its ID (example function)
    function getClassName(uint256 classId) public pure returns (string memory) {
        if (classId == 1) return "Mage";
        if (classId == 2) return "Cleric";
        if (classId == 3) return "Archer";
        if (classId == 4) return "Assassin";
        if (classId == 5) return "Swordsman";
        if (classId == 6) return "Shield";
        if (classId == 7) return "Berserker";
        if (classId == 8) return "Orc";
        if (classId == 9) return "Vanguard";
        if (classId == 10) return "Spearman";
        return "Unknown Class";
    }

    // Check token balance
    function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    // Get all classes redeemed by a player (by string names)
    function getPlayerClasses(address player) external view returns (string[10] memory) {
        string[10] memory classes;
        for (uint256 i = 1; i <= 10; i++) {
            if (playerClasses[player][i]) {
                classes[i - 1] = getClassName(i);
            }
        }
        return classes;
    }

    // Get all available classes with their IDs and names
    function getAllClasses() external pure returns (string[10] memory) {
        string[10] memory allClasses;
        allClasses[0] = "1 - Mage";
        allClasses[1] = "2 - Cleric";
        allClasses[2] = "3 - Archer";
        allClasses[3] = "4 - Assassin";
        allClasses[4] = "5 - Swordsman";
        allClasses[5] = "6 - Shield";
        allClasses[6] = "7 - Berserker";
        allClasses[7] = "8 - Orc";
        allClasses[8] = "9 - Vanguard";
        allClasses[9] = "10 - Spearman";
        return allClasses;
    }
}
