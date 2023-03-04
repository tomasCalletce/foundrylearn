// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

   /*
      Why Periphery and not core contracts?

      The periphery is a constellation of smart contracts designed to support domain-specific 
      interactions with the core. Because of Uniswap's permissionless nature, the contracts 
      described below have no special privileges, and are in fact only a small subset of the universe 
      of possible periphery-like contracts. However, they are useful examples of how to safely 
      and efficiently interact with Uniswap V2.
   */
import { IUniswapV2Router02 } from "v2-periphery/interfaces/IUniswapV2Router02.sol";

contract Unisawp is Test {

    IUniswapV2Router02 UniswapV2Router02 = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    address UniswapV2Factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    uint256 mainnetFork;

    constructor(){
        mainnetFork = vm.createFork(vm.envString("MAINNET_RPC_URL"));
    }

    function setUp() public {
        // runs before every test 
        // every test has an independent state
    }

    function testCanGetCorrectFactoryAddress() public {
        vm.selectFork(mainnetFork);

        address uniswapV2Factory = UniswapV2Router02.factory();
        assertEq(uniswapV2Factory, UniswapV2Factory);
    }


}