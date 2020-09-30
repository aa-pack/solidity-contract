pragma solidity ^0.5.0;

contract TieredProfitSplitter {
    address payable employeeOne; // ceo
    address payable employeeTwo; // cto
    address payable employeeThree; // bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employeeOne = _one;
        employeeTwo = _two;
        employeeThree = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // Calculate and transfer the distribution percentage
        amount = points * 60;
        total += amount;
        employeeOne.transfer(amount);

        amount = points * 25;
        total += amount;
        employeeTwo.transfer(amount);

        amount = points * 15;
        total += amount;
        employeeThree.transfer(amount);


        employeeOne.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}
