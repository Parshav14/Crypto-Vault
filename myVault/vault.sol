// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract myvault {
    address public owner;

    struct locker {
        uint256 value;
        uint256 locked_time;
    }
    uint count = 0;
    mapping(uint => locker) public Vault;

    modifier onlyOwner() 
    {
        require(msg.sender == owner, "I can access it only!");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function deposit(uint256 _time)
    public 
    payable 
    onlyOwner {
        count+=1;
        Vault[count].locked_time = _time;
        Vault[count].value = msg.value;
    }
    function withdraw(uint _lockerNumber)
    public 
    onlyOwner {
        require(block.timestamp >= Vault[_lockerNumber].locked_time, "Come back Next time!");
        payable(owner).transfer(Vault[_lockerNumber].value);

    }

}