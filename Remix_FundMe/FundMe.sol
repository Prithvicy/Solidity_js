// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConvertor.sol";
    error notOwner();

contract FundMe {
    using PriceConvertor for uint256;
    //Step 1 write down all the functions we need
    uint256 constant MINIMUM_USD = 10 * 1e18; // when we add const it no longer takes storage
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner; 

    constructor (){
        i_owner=msg.sender;
    }

    function fund() public payable {
        //want to keep min fund amount in usd
        require(
            (msg.value.getConversionRate()) >= MINIMUM_USD,
            "Didnt send enough baka , gimme more eth"
        ); //1e18 == 1*10 ^18==1 with 18 zeroes value of 1 et in wei
        //iff less money then revery
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    //Revert is when we undo anything that happen (alreafy executed function) and send the remaining gas back

    function withdraw () public onlyi_owner {
        // require (msg.sender==i_owner);
        for (uint256 funderIndex; funderIndex < funders.length; funderIndex++) {
            //code
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the arry
        funders = new address[](0);

        // //withraw the moneyy is possible in 3 ways
        // //transfer automatically reverts
        // payable(msg.sender).transfer(address(this).balance);

        // //send only reverts if we specify require
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send failed");

        //call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed"); //we make the address payable since we can only send funds to payable address
    }
    modifier onlyi_owner{
        if (msg.sender != i_owner) revert notOwner();
        _; //underscore represents doing the rest of the code 
    }
    //What happens if someone sendss eth without calling fund function 
    receive() external payable{
        fund();
    }
    fallback() external payable{
        fund();
    }

}
