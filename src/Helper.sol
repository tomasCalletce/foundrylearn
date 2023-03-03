// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract Helper {
    uint256 public number;
    address public lastMsgSender;

    function setNumber(uint _number) external {
        number = _number;
    }

    function setLastMsgSender() external {
        lastMsgSender = msg.sender;
    }
}