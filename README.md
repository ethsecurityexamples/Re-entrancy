[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/1.jpg)](http:https://github.com/ethsecurityexamples/Re-entrancy/blob/main/1.jpg//)

Take a look to the contract:

    Reentrancy.sol

Reentrancy bug is one of the worst bugs you could suffer in your contract, because your contract could lose all its stored ETH.

Reentrancy bug happens when contract A calls contract B, and B is able to call back into A before A finishes execution.

In the example: A is *VulnerableContract* contract, and B is *Exploit* contract.


[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/2.jpg)](http:https://github.com/ethsecurityexamples/Re-entrancy/blob/main/2.jpg/)

First, let's see the bug working:

Deploy the vulnerable contract:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/3.jpg)](http://https://github.com/ethsecurityexamples/Re-entrancy/blob/main/3.jpg)

Now with two different addresses send 1 ETH each, to the vulnerable contract, using its function *deposit* :

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/4.jpg)](http://https://github.com/ethsecurityexamples/Re-entrancy/blob/main/4.jpg)

Let's check the variable *balances* to see that ETH is properly sent.
In the image we can see one of the 1 ETH stored in the vulnerable contract:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/5.jpg)](http:/https://github.com/ethsecurityexamples/Re-entrancy/blob/main/5.jpg/)

Now deploy the hacker contract, *Exploit* :
(use for it the address of the vulnerable contract)

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/6.jpg)](http://https://github.com/ethsecurityexamples/Re-entrancy/blob/main/6.jpg)



Before execute the exploit, let's check that vulnerable contract has 2 ETH: the 2 ETH that we sent before with 2 different addreses:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/7.jpg)](http://https://github.com/ethsecurityexamples/Re-entrancy/blob/main/7.jpg)

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


------------


So, how we can avoid this horrible situation for our code?

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/11.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/11.jpg)

Let's repeat the process againg, and see how the vulnerable contract has 2 ETH.

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/12.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/12.jpg)

Now we execute the exploit by sending again 1 ETH to the vulnerable contract from *Exploit* contract. 
But now we can see that we got an error, an exception launched by the EVM.

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/13.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/13.jpg)

This is due to the change of the execution order of the buggy instruction.
The trick is update the balance of vulnerable contract, BEFORE we execute the instruction of withdraw ETH.
In this case, the reentrancy code is not possible anymore, because the balance of the vulnerable contract for that address is now 0.


Let's check that vulnerable contract still has 2 ETH:

[![](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/14.jpg)](https://github.com/ethsecurityexamples/Re-entrancy/blob/main/14.jpg)