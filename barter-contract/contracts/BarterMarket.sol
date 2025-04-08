// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "./BarterCoin.sol";

contract BarterMarket {
    BarterCoin public barterCoin;
    uint256 public nextItemId = 1;
    mapping(uint256 => Item) public items;

    struct Item {
        uint256 id;
        string name;
        string description;
        uint256 price;
        address owner;
        bool onSale;
    }

    event ItemListed(uint256 id, string name, address owner, uint256 price);
    event ItemSold(uint256 id, address buyer, address owner, uint256 price);
    event ItemSale(uint256 id, string name, address owner, uint256 price);

    constructor(address _barterCoin) {
        barterCoin = BarterCoin(_barterCoin);
    }

    function listItem(
        string memory _name,
        string memory _description,
        uint256 _price
    ) public {
        require(_price > 0, "Price must be greater than zero");
        require(
            bytes(_name).length > 0 && bytes(_description).length > 0,
            "Name and description are required"
        );

        Item memory newItem = Item({
            id: nextItemId,
            name: _name,
            description: _description,
            price: _price,
            owner: msg.sender,
            onSale: true
        });

        items[nextItemId] = newItem;
        emit ItemListed(nextItemId, _name, msg.sender, _price);
        nextItemId++;
    }

    function buyItem(uint256 _itemId) public {
        require(_itemId > 0 && _itemId < nextItemId, "Item does not exist");
        Item storage item = items[_itemId];
        require(item.onSale, "Item is not on sale");
        require(msg.sender != item.owner, "Ownder cannot buy their own item");
        require(
            barterCoin.balanceOf(msg.sender) >= item.price,
            "Insufficient balance"
        );

        barterCoin.transfer(item.owner, item.price);
        item.onSale = false;
        item.owner = msg.sender;

        emit ItemSold(_itemId, msg.sender, item.owner, item.price);
    }

    function placeOnSale(uint256 _itemId) public {
        require(_itemId > 0 && _itemId < nextItemId, "Item does not exist");
        Item storage item = items[_itemId];
        require(
            msg.sender == item.owner,
            "You can only place items you own on sale"
        );
        item.onSale = true;

        emit ItemSale(item.id, item.name, item.owner, item.price);
    }
}
