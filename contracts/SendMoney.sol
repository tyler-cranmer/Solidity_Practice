//SPDX-License-Idenfitier: MIT
pragma solidity ^0.5.13;

contract sendMoneyExample{
    
    uint public balanceRecieved;
    uint public lockedUntil;
    
    function recieveMoney() public payable {
        balanceRecieved += msg.value;
        lockedUntil = block.timestamp + 1 minutes;
    }
    
    function getBalance() public view returns(uint) {
     return address(this).balance;   
    }
    
    function withdrawMoney() public {
        if(lockedUntil < block.timestamp)
      {  address payable to = msg.sender;
        to.transfer(this.getBalance()); }
    }
    
    function withdrawMoneyTo(address payable _to) public {
        if(lockedUntil < block.timestamp){ 
            _to.transfer(this.getBalance());
            
        }
    }
}
