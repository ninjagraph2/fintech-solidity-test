// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "src/SimpleWallet.sol"; // путь к вашему контракту

contract SimpleWalletTest is Test {
    SimpleWallet wallet;
    address owner = address(this); // владелец
    address user = address(0x123); // сторонний пользователь

    function setUp() public {
        wallet = new SimpleWallet(); // Деплой контракта
    }

    function testOwnerInitialization() public {
        assertEq(wallet.owner(), owner, "Owner must be deployer");
    }

    function testReceiveFunds() public {
        uint initialBalance = wallet.getBalance();
        vm.deal(address(this), 1 ether); // Выдать баланс тестовому контракту
        payable(address(wallet)).transfer(0.5 ether); // Перевод на контракт

        assertEq(wallet.getBalance(), initialBalance + 0.5 ether, "Balance not changes");
    }

    function testTransfer() public {
        vm.deal(address(wallet), 1 ether); // Установить баланс контракта
        uint initialUserBalance = user.balance;

        wallet.transfer(payable(user), 0.5 ether); // Перевод средств

        assertEq(user.balance, initialUserBalance + 0.5 ether, "The funds have not been received by the user");
        assertEq(wallet.getBalance(), 0.5 ether, "No funds were debited from the contract");
    }

    function testWithdraw() public {
        vm.deal(address(wallet), 1 ether); // Установить баланс контракта
        uint initialOwnerBalance = owner.balance;

        wallet.withdraw(0.5 ether); // Вывод средств

        assertEq(owner.balance, initialOwnerBalance + 0.5 ether, "The funds have not been received by the owner");
        assertEq(wallet.getBalance(), 0.5 ether, "No funds were debited from the contract");
    }

    function testFailNonOwnerTransfer() public {
        vm.prank(user); // Изменить msg.sender на user
        wallet.transfer(payable(user), 0.5 ether); // Ожидается ошибка
    }

    function testFailNonOwnerWithdraw() public {
        vm.prank(user); // Изменить msg.sender на user
        wallet.withdraw(0.5 ether); // Ожидается ошибка
    }

    function testFailInsufficientBalanceTransfer() public {
        wallet.transfer(payable(user), 1 ether); // Попытка перевода при недостаточном балансе
    }

    function testFailInsufficientBalanceWithdraw() public {
        wallet.withdraw(1 ether); // Попытка вывода при недостаточном балансе
    }
}
