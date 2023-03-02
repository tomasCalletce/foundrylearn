// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Wallet {
    
    mapping(address => uint) public balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdarw() external {
        uint amount =  balance[msg.sender];
        balance[msg.sender] = 0;

        (bool success, ) = address(msg.sender).call{value: amount}("");
        require(success, "WITHDRAW_FAILED");
    }

    function getMyBalance() external view returns (uint myBalance){
        myBalance = balance[msg.sender]; 
    }

}
