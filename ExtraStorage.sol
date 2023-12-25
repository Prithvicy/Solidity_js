//SPDX-identifier : MIT 
pragma solidity ^0.8.0;
import "./SimpleStorage";
contract ExtraStorage is SimpleStorage{ // for inheritance 
    function store(uint256 _fav_num) public override {
        //to overrride we need to change function main to virtual and this function should have oveerrride keyword
        FavNum = _fav_num+5;
    }
}