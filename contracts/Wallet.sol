//SPDX-License-Identifier: MIT
pragma solidity >=0.8.1 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "./Allowance.sol";


//@title Smart SharedWallet
//@notice This is a contract for a shared wallet, that allows the owner to distribute funds/allowances to different accounts. 
//@dev imports Allowance methods from Allowance.sol.

contract SharedWallet is Allowance {
    
    event FundsSent(address indexed _beneficiary, uint _amount); 
    event FundsRecieved(address indexed _from, uint _amount);
    
    uint public AccountBalance; //Account Balance of shared wallet
    
    //@notice function to deposit funds into SharedWallet
    //@dev Account Balance stores the funds within the entire Wallet. Allowance is the amount alloted for each account.
    function DepositFunds() public payable {
        AccountBalance += msg.value;
        allowance[msg.sender] += msg.value;
    }
    
    //@notice withdraws the funds from account.
    //@param1 account address of where funds will be transfered.
    //param2 amount of funds to be transfered. 
    function WithdrawFunds(address payable _to, uint _amount) public ownerOrAllowed(_amount) { // Withdraw funds from account, onlyOwner of Smart Contract can access.
        require(_amount <= address(this).balance, "Account Doesnt have enough funds.");
        if(!isOwner()){
            reduceAllwance(msg.sender, _amount);
        }
        emit FundsSent(_to, _amount);
        AccountBalance -= _amount;
        _to.transfer(_amount);
    } 
    
    //@notice renounces the ownership of the contract, sets to 0x0000
    function renounceOwnership() public override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }

    //@notice fallback function
    receive() external payable {
       emit FundsRecieved(msg.sender, msg.value);
    }
    
}