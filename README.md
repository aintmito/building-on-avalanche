# Degen Token / MMORPG Game

This Solidity program is a simple Contract program that implements an MMORPG game and demonstrates the basic syntax and functionaly of the Solidity programming language. The purpose of this program is to serve as a starting point for people like me who are new to Solidity and wants to know the fundamentals of how crypto wallet works.

## Description

This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract can create an an ERC20 token named Degen and has eight functions that mints, transfer, burn tokens, etc. This program serves as a simple introduction to Solidity programming. It can be used as a basis and can further improve to a more complex projects in the future.

## Getting Started

### Executing program

* To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

* Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the following code into the file:

```
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

```

* To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then select "Advanced Configurations", from the EVM Version, select "petersburg". Click on the "Compile DegenToken.sol" button.

* Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken - DegenToken.sol" contract from the dropdown menu, input the name of your token, its symbol, and initial supply. Then, click on the "transact" button.

* Once the contract is deployed, you can interact with it by checking the name, owner, symbol, and totalSupply variables to check their values. After checking their values, in the left-hand sidebar, scroll up so you can check the "Account" that gives example addresses that you can use for testing the program and copy the default address that is already selecting in the dropdown menu.

## Authors

[Miguel Andre Encomienda](https://www.linkedin.com/in/miguel-encomienda-526593292/)


## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details