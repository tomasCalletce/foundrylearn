// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import { IWETH9 } from "custom/IWETH9.sol";

contract ForkTest is Test {

    uint256 mainnetFork;
    uint256 arbFork;

    address wethArb = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
    address wethMainnet = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    constructor(){
        mainnetFork = vm.createFork(vm.envString("MAINNET_RPC_URL"));
        arbFork = vm.createFork(vm.envString("ARB_RPC_URL"));
    }

    function setUp() public {
        // runs before every test 
        // every test has an independent state
    }

    function  testMultipleForkSelection() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        vm.selectFork(arbFork);
        assertEq(vm.activeFork(), arbFork);
    }

    function testCanMintWETHinArb() public {
        vm.selectFork(arbFork);
         // from here on out the code will execute on the forked environment
        IWETH9 weth = IWETH9(wethArb);
        
        // mint weth 
        weth.deposit{ value: 100 ether }();
        assertEq(weth.balanceOf(address(this)),100 ether);
    }

    function testCanMintWETHinMainnet() public {
        vm.selectFork(mainnetFork);
         // from here on out the code will execute on the forked environment
        IWETH9 weth = IWETH9(wethMainnet);
        
        // mint weth 
        weth.deposit{ value: 100 ether }();
        assertEq(weth.balanceOf(address(this)),100 ether);
    }

    function testChangesInAForkStayInThatFork() public {
        vm.selectFork(arbFork);

        address receiver = 0xE7351d0B85f4D88dED9c39C71D1685820680ca8A;

        (bool success, ) = receiver.call{value: 100 ether}("");
        require(success, "NO_SEND");

        assertEq(receiver.balance,100 ether);

        vm.selectFork(mainnetFork);

        assertEq(receiver.balance,0);
    }

    function testNoChangesInThePast() public {
        vm.selectFork(arbFork);

        address receiver = 0xE7351d0B85f4D88dED9c39C71D1685820680ca8A;

        (bool success, ) = receiver.call{value: 100 ether}("");
        require(success, "NO_SEND");

        assertEq(receiver.balance,100 ether);

        vm.rollFork(2_6147_000);

        assertEq(receiver.balance,0);
    }

}