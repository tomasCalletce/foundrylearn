// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract IWETH9 {
    string public name;
    string public symbol;
    uint8  public decimals;

    mapping (address => uint)  public  balanceOf;
    mapping (address => mapping (address => uint))  public  allowance;

    function deposit() public payable{}
    function withdraw(uint wad) public{}
    function totalSupply() public view returns (uint){}
    function approve(address guy, uint wad) public returns (bool){}
    function transfer(address dst, uint wad) public returns (bool){}
    function transferFrom(address src, address dst, uint wad) public returns (bool){}
}