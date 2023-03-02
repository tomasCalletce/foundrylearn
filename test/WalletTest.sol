// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";

import { Wallet } from "../src/Wallet.sol";

contract CounterTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function testDeposit() public {
        wallet.deposit{ value: 100 ether }();
        assertEq(wallet.balance(address(this)),100 ether);
    }

    function testBalanceMapping() public {
        wallet.deposit{ value: 100 ether }();

        // only the directly below line will be called using the specified address
        vm.prank(address(0));
        uint balance0 = wallet.getMyBalance();
        assertEq(balance0,wallet.balance(address(0)));

        uint balanceThis = wallet.getMyBalance();
        assertEq(balanceThis,wallet.balance(address(this)));
    } 
}

