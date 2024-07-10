 ### Use of Error Handling By require(),assert(),revert()
 ## Video Explanation 
 https://www.loom.com/share/26678c09f7094e3391cfbe137497e923
# Netflix Subscription 
- This program shows a simple contract made in Solidity to subscribe , renew , or cancel your netflix subscription.
- ## Description
- The 'NetflixSubscription.' contract allows user to subscribe , renew , or cancel your netflix subscription using your address while using certain restrictions to ensure no error.
- It contains state variables **owner** storing the address of contract owner,**subscription_Fee** which is initialised to the value of 2 ether,another variable **subscription_Duration** set to value 30 days.
- It contains modifier **onlySubscriber()** that restricts the execution of certain functions to the active subscribers only.
- Contructor sets the deployer's address as the contract owner.
- #### Event
    **Subscribed**, **Renewed**,**Canceled**, are used to log the the crucial information such as subscribers address , and subscription end date.
- 
- #### Functions
- **subscribe_Netflix()**,**renewSubscription()**,**cancelSubscription()** Allows users to subscribe for new service ,renew existing plan or cancel active subscription.
- ## Executing Program
-  We can use remix- an online solidity compiler to run this Program at remix.ethereum.
-  Create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension.
- Copy and paste the following code into the file.

``` // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NetflixSubscription {

    address public owner;
    uint public subscription_Fee = 2 ether;
    uint public subscription_Duration = 30 days;

    struct Subscriber_Data{
        bool activationStatus;
        uint subscription_tillDate;
    }
     
   mapping(address => Subscriber_Data) public subscribers;

       event Subscribed(address indexed subscriberinfo, uint endTime);
    event Renewed(address indexed subscriberinfo, uint newEndTime);
    event Canceled(address indexed subscriberinfo);

      

    modifier onlySubscriber() {
        require(subscribers[msg.sender].activationStatus, "You are not an active subscriber.");
        require(subscribers[msg.sender].subscription_tillDate > block.timestamp, "Your subscription has expired.");
    
        _;

    }
        constructor() {
        owner = msg.sender;
    }
    function subscribe_Netflix() public payable {
        require(msg.value == subscription_Fee, "Incorrect subscription fee.");
        

        if (subscribers[msg.sender].activationStatus) {
            revert("You are already subscribed to Netflix.");
        }
        subscribers[msg.sender].activationStatus = true;
        subscribers[msg.sender].subscription_tillDate = block.timestamp + subscription_Duration;

        assert(subscribers[msg.sender].subscription_tillDate > block.timestamp);
        emit Subscribed(msg.sender, subscribers[msg.sender].subscription_tillDate);
    }
    function renewSubscription() public payable onlySubscriber {
   
        require(msg.value == subscription_Fee, "Incorrect subscription fee.");
        Subscriber_Data memory subscriber = subscribers[msg.sender];
        
        require(subscriber.subscription_tillDate > block.timestamp, "Your subscription has expired. Please subscribe again.");
        
        subscriber.subscription_tillDate += subscription_Duration;
        assert(subscriber.subscription_tillDate > block.timestamp);

        subscribers[msg.sender] = subscriber; 

        emit Renewed(msg.sender, subscriber.subscription_tillDate);
    }
    function cancelSubscription() public onlySubscriber {
        Subscriber_Data memory subscriber = subscribers[msg.sender];
        subscriber.activationStatus = false;
        subscriber.subscription_tillDate = 0;

        subscribers[msg.sender] = subscriber; 

        emit Canceled(msg.sender);
    }



}


   



```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.20" (or another compatible version), and then click on the "Netflixsubscription.sol" button.
    
Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the **NetflixSubscription** contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the  subscribe_Netflix(), renewSubscription(),cancelSubscription()  function by any existing account in the list. 

## Authors
Devesh Singh Metacrafters deveshsingh5603@gmail.com

## License
This project is licensed under the MIT License - see the LICENSE.md file for details

 
