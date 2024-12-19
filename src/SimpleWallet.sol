// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract SimpleWallet {
    
    address public owner;

    event Transfer(address indexed to, uint amount);
    event Withdraw(address indexed to, uint amount);

    constructor() {
        owner = msg.sender; // владелец контракта
    }

    // пополнение кошелька
    receive() external payable {}

    // перевод средств
    function transfer(address payable _to, uint _amount) public {
        require(msg.sender == owner, "Only owner can transfer funds");
        require(address(this).balance >= _amount, "Insufficient balance");
        
        _to.transfer(_amount);
        emit Transfer(_to, _amount); // логирование
    }

    // вывод средств на аккаунт владельца
    function withdraw(uint _amount) public {
        require(msg.sender == owner, "Only owner can withdraw funds");
        require(address(this).balance >= _amount, "Insufficient balance");

        payable(owner).transfer(_amount);
        emit Withdraw(owner, _amount); // логированние
    }

    // проверка баланса контракта
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}