[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/1.jpg)](http:https://github.com/ethsecurityexamples/Re-entrancy/blob/main/1.jpg//)

Take a look to the contract:

    Reentrancy.sol

Reentrancy bug happens when contract A calls contract B, and B is able to call back into A before A finishes execution.

In the example: A is *VulnerableContract* contract, and B is *Exploit* contract.


[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/2.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/2.jpg/)

First, let's see the bug working:

Deploy the vulnerable contract:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/3.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/3.jpg)

Now with two different addresses send 1 ETH each, to the vulnerable contract, using its function *deposit* :

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/4.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/4.jpg)

Let's check the variable *balances* to see that ETH is properly sent.
In the image we can see one of the 1 ETH stored in the vulnerable contract:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/5.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/5.jpg/)

Now deploy the hacker contract, *Exploit* :
(use for it the address of the vulnerable contract)

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/6.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/6.jpg)



Before execute the exploit, let's check that vulnerable contract has 2 ETH: the 2 ETH that we sent before with 2 different addreses:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/7.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/7.jpg)

Now let's execute the exploit, sending 1 ETH to vulnerable contract using *exploit* function on *Exploit* contract.

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/8.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/8.jpg/)

And finally let's check again the balance of vulnerable contract: 
let's remember it had 2 ETH:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/9.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/9.jpg)

¡Right now vulnerable contract has lost all its ETH! It's balance now is 0 ETH.

But where are the 2 ETH then?

They are now stored in the Exploit contract! , plus the 1 ETH that Exploit contract sent to vulnerable contract. 
Let's check the balance on Exploit contract to see it:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/10.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/10.jpg)