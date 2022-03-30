// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract StartStopUpdateExample{
    
    address public owner;
    bool public pause;
    
    constructor(){
        owner = msg.sender;
    }
    
    function SendMoney() public payable {
        
    }
    
    function setPaused(bool _pause) public {
        require(msg.sender == owner, "You are not the owner.");
        pause = _pause;
    }
    
    function withdrawAllMoney(address payable _to) public {
        require(owner == msg.sender, "You cannot withdraw.");
        require(!pause, "Contract is paused");
        _to.transfer(address(this).balance);
    }
    
    function destroyContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        require(!pause, "Contract is paused.");
        selfdestruct(_to);
    }
}