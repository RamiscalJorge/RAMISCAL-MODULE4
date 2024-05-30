The module is given to us to teach us the fundamentals of creating a block chain

 Description

This program aims to help us understand the basics and also to give us a knowledge about 
block chain

 Getting Started
 To be able to execute this application, you may use Remix, an online Solidity IDE, which can be found at https://remix.ethereum.org/.

 Create a new file on the Remix website by clicking the "+" symbol in the left-hand sidebar. Save the file as Phoenixtoken.sol . Insert the following code into the file:
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// ERC20 contract with mint, burn, transfer, redeem, and check balance
contract DegenToken is ERC20, Ownable {
    // Mapping to store the prices of each shoe item
    mapping(uint256 => uint256) public itemPrices;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** uint(decimals()));

        // Add some shoe items and their prices
        itemPrices[1] = 100; // Item ID: 1, Price: 100 tokens
        itemPrices[2] = 150; // Item ID: 2, Price: 150 tokens
        itemPrices[3] = 200; // Item ID: 3, Price: 200 tokens
    }

    function mint(address account, uint256 amount) public {
        require(msg.sender == owner(), "Only owner can mint new tokens");
        _mint(account, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address");
        return super.transfer(to, amount);
    }

    // Redeem items by burning tokens
    function redeem(uint256 itemId) public {
        uint256 price = itemPrices[itemId];
        require(price > 0, "Item not available for redemption");
        require(balanceOf(msg.sender) >= price, "Insufficient balance");
        _burn(msg.sender, price);
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return super.balanceOf(account);
    }
}


Authors
Jorge ramiscal
@JRamiscal

Contributors names and contact info

Ramiscal Jorge
[@Jay2kkkk](https://twitter.com/Jay2kkkk)


## License

This project is licensed under the Ramiscal Jorge License - see the LICENSE.md file for details
