// SPDX-License-Identifier: MIT
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
