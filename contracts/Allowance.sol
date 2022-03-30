//SPDX-License-Identifier: MIT
pragma solidity >=0.8.1 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol\";

//@title Allowance.sol
//@notice This is a contract used to assist wallet.sol. This contract will set Allowances for different accounts. 
//@dev imports Owner methods from sw_Owner.sol.
contract Allowance is Ownable {

   event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount); //event emitted when Allounce gets changed.
   mapping(address => uint) public allowance; //Allowance of shared account
    
    
    //@notice function returns true or false when the msg.sender is the owner of the contract.
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    
    //@notice deposits funds into into specific accounts allowance pool.  
    // only the owner of the contract has ability to set allowance.
    //@param1 address of account to give allowance to.
    //@param2 total amount of allowance
    function setAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
    }
    
    //@notice modifier for WithdrawFunds. Requires the owner of the contract or the account with an allowance to withdrawl funds. 
    //@param1 allowance amount to be retrieved. 
     modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, This Account does not have permission to do that.);
        _;
    }
    
    
    //@notice reduced the allowance for given account
    //@param1 address of account to give allowance to.
    //@param2 total amount of allowance
    function reduceAllwance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
    

}

