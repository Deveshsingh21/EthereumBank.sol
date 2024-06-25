 ### Use of Error Handling By require(),assert(),revert()
# ETH + AVAX Intermediate Course 
- This program shows a simple contract made in Solidity to deposit and transfer ether into a particular account
- ## Description
- The 'EthereumBank' contract allows user to deposit and withdrawal Ether into the contract while using certain restrictions to ensure no error.
- It contains state variables **owner** storing the address of contract owner,**balances** stores the ETH balance for each user as mapping.
- It contains modifier **onlyOwner** that restricts the execution of certain functions to the contract owner.
- Contructor sets the deployer's address as the contract owner.
- #### Event
- **Deposit**,**Withdraw**, are used to log the the crucial information such as deposit details,withdrawaldetails.
- 
- #### Functions
- **DepositEth()**,**WithdrawalEth(uint amount)**,**getBalance()** Allows users to deposit Ether ,withdraw Ether, get the balance of the sender.
- ## Executing Program
-  We can use remix- an online solidity compiler to run this Program at remix.ethereum.
-  Create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension.
- Copy and paste the following code into the file.

''' <solidity>
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
    event FullWithdrawl(address indexed account, uint amount);


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

'''

 
