[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/1.jpg)](http:https://github.com/ethsecurityexamples/Re-entrancy/blob/main/1.jpg//)

Take a look to the contract:

    Reentrancy.sol

Reentrancy bug happens when contract A calls contract B, and B is able to call back into A before A finishes execution.

In the example: A is *VulnerableContract* contract, and B is *Exploit* contract.

