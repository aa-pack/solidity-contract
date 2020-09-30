pragma solidity ^0.5.0;

contract DeferredEquityPlan {
    address humanResources;

    address payable employee; // bob
    bool active = true; // this employee is active at the start of the contract

    // Set the total shares and annual distribution
    uint totalShares = 1000;
    annualDistribution = 250;


    uint startTime = now; // permanently store the time this contract was initialized

    // Set the `unlockTime` to be 365 days from now
    unlockTime = now + 365 days;

    uint public distributedShares; // starts at 0

    constructor(address payable _employee) public {
        humanResources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == humanResources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");

        // Add "require" statements to enforce that:
        require(unlockTime <= now);
        require(distributedShares < totalShares);

        // Add 365 days to the `unlockTime`
        unlockTime = now + 365 days;

        // Calculate the shares distributed by using the function (now - startTime) / 365 days * the annual distribution
        // Make sure to include the parenthesis around (now - startTime) to get accurate results!
        distributedShares = (now - startTime) / 365 days * annualDistribution

        // double check in case the employee does not cash out until after 5+ years
        if (distributedShares > 1000) {
            distributedShares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == humanResources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}
