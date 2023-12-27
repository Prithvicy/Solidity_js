//SPDX-identifier : MIT 
pragma solidity ^0.8.0;

import "./SimpleStorage";
contract ExtraStorage is SimpleStorage{ // for inheritance use is keyword
    function store(uint256 _fav_num) public override {
        //to overrride we need to change function main to virtual and this function should have oveerrride keyword
        FavNum = _fav_num+5;
    }
}

//For inheritance we use the is keyword 
//To Override a function we have to first change the other function in main contract make it virtual
//Then change the function in this inherited contract and use the keyword override