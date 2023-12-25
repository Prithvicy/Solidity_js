// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; //specify version

//^ this allows any version later than the one mentioned >=0.8.7 <0.9.0
//keyword : cotnract ( something like class)
contract SimpleStorage {
    //boolean , uint , int , address , bytes
    // string FavNumText = "Five"; //words or phrase
    // int256 FavInt = -5;
    // address myAddress = 0x79AEAD340f47885ecB3669D2303D75B7BFDE2341;
    // bytes32 FavBytes = "cat"; // strings are actually byte objecy but only for text
    // //max byte we can have is 32

    // people public person = people({FavNum:9 ,name:"prith" });
    people[] public People;
    struct people {
        uint256 FavNum;
        string name;
    }

    function addPeople(string memory _name, uint256 _favNum) public {
        People.push(people(_favNum, _name));
        NameToFavNum[_name] = _favNum;
    }

    mapping(string => uint256) public NameToFavNum; //maps a striong to int

    uint256 public FavNum; // if you dont specify it automatically becomes 256 byte size (uint 256)

    //if we dont initalize a variabe it get initialized to 0 automatically

    function store(uint256 _fav_num) public {
        FavNum = _fav_num;
    }

    function retrieve() public view returns (uint256) {
        return FavNum;
    }

    function add() public pure returns (uint256) {
        return (1 + 1);
    }
}
//Some important notes
//Every contract has its own unique address after deploying
//view and pure functions dont need gas
