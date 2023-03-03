// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";

import { Helper } from "../src/Helper.sol";

contract Environment is Test {

    Helper helper;

    function setUp() public {
        helper = new Helper();
    }

    function testCanSetBlockTimestamp() public {
        vm.warp(1641070800);
        assertEq(block.timestamp,1641070800);
    }

    function testCanSetBlockNumber() public {
        vm.roll(100);
        assertEq(block.number,100);
    }

    function testCanSetChainId() public {
        vm.chainId(31337);
        assertEq(block.chainid,31337);
    }

    function testManuallyStoreValue() public {
        vm.store(address(helper), bytes32(uint256(0)), bytes32(uint256(4)));
        assertEq(helper.number(),4);
    }

    function testManuallyReadValue() public {
        helper.setNumber(4);
        uint number = uint256(vm.load(address(helper), bytes32(uint256(0))));
        assertEq(helper.number(),number);
    }

    function setBalanceOfAdress() public {
        address newAdress = address(1);
        vm.deal(newAdress, 10 ether);
        assertEq(newAdress.balance,10 ether);
    }

    function testSetMsgSender() public {
        address newAdress = address(1);
        // prank only changes the msg.sender of the function directly after, expect of the call is a cheat code
        vm.prank(newAdress);
        helper.setLastMsgSender();

        assertEq(helper.lastMsgSender(),newAdress);
    }

}



