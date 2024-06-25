// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EthereumBank {
    address public owner;
    mapping(address => uint)private balances;

    modifier onlyOwner(){
        require(msg.sender == owner,"Only Owner Authorised for Transaction");
        _;
    }

    constructor() {
        owner = msg.sender;

    }
    event Deposit(address indexed account, uint amount);
    event Withdraw (address indexed account, uint amount);
   


    function DepositEth()public payable {
        require(msg.value > 0, "Deposit Amount Greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender,msg.value);
    }
    function WithdrawalEth(uint amount)public  {
        require(amount > 0, "Withdraw Amount Greater than 0");
        if(balances[msg.sender]< amount){
            revert("not enough balances");
        }
      

        uint initialBalance = address(this).balance;
        assert (initialBalance >= amount);
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        assert(address(this).balance == initialBalance - amount);
        emit Withdraw(msg.sender,amount);
    }
    function getBalance() public view returns (uint){
        return balances[msg.sender];
    }


}
