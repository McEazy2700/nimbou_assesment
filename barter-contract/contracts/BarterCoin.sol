// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract BarterCoin {
    address public superAdmin;
    address[] public admins;
    string public name = "Barter Coin";
    string public symbol = "BC";
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    constructor() {
        superAdmin = msg.sender;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);

    modifier onlySuperAdmin() {
        require(msg.sender == superAdmin, "Unauthorized action");
        _;
    }

    modifier onlyAdmin() {
        bool isAdmin = false;
        for (uint i = 0; i < admins.length; i++) {
            if (admins[i] == msg.sender) {
                isAdmin = true;
                break;
            }
        }
        require(isAdmin, "Unauthorized action! Not an admin");
        _;
    }

    function addAdmin(address _admin) external onlySuperAdmin {
        admins.push(_admin);
    }

    function removeAdmin(address _admin) external onlySuperAdmin {
        require(admins.length > 0, "No admins to remove");
        for (uint i = 0; i < admins.length; i++) {
            if (admins[i] == _admin) {
                admins[i] = admins[admins.length - 1];
                admins.pop();
                return;
            }
        }

        require(false, "Admin not found");
    }

    function mint(address to, uint256 amount) public onlyAdmin {
        totalSupply += amount;
        balances[to] += amount;
        emit Mint(to, amount);
        emit Transfer(address(0), to, amount);
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        require(to != address(0), "Cannot transfer to the zero address");
        require(value > 0, "Transfer amount must be greater than zero");
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        balances[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
}
