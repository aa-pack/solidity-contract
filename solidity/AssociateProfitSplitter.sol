pragma solidity ^0.5.0;

contract AssociateProfitSplitter {
    // Create three payable addresses representing `employeeOne`, `employeeTwo` and `employeeThree`.
    address payable employeeOne;
    address payable employeeTwo;
    address payable employeeThree;


    constructor(address payable _one, address payable _two, address payable _three) public {
        employeeOne = _one;
        employeeTwo = _two;
        employeeThree = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // Split `msg.value` into three
        uint amount = msg.value / 3;

        // ransfer the amount to each employee
        employeeOne.transfer(amount);
        employeeTwo.transfer(amount);
        employeeThree.transfer(amount);

        // Take care of a potential remainder by sending back to HR (`msg.sender`)
        uint leftoverAmount = msg.value - amount * 3;
        msg.sender.transfer(leftoverAmount);
    }

    function() external payable {
        // Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}
