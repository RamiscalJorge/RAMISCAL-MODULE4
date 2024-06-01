// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// ERC20 contract with mint, burn, transfer, redeem, and check balance
contract DegenToken is ERC20, Ownable {
    // Mapping to store the prices of each shoe item
    mapping(uint256 => uint256) public itemPrices;
    // Mapping to store the redeemed items for each user
    mapping(address => uint256[]) public redeemedItems;
    event ItemRedeemed(address indexed user, uint256 indexed itemId);

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
        redeemedItems[msg.sender].push(itemId);
        emit ItemRedeemed(msg.sender, itemId); // Emit event to log the redemption
    }

    function getRedeemedItems(address account) public view returns (uint256[] memory) {
        return redeemedItems[account];
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return super.balanceOf(account);
    }
}
