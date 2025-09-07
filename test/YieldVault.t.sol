//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/YieldVaultTest.sol";

contract YieldVaultTest is Test {
    YieldVault vault;
    address mamba = address(0xA11CE);
    address richard = address(0xB0B);

    function setUp() public {
        vault = new YieldVault(100); //1% fee
        vm.deal(mamba, 10 ether);
        vm.deal(richard, 10 ether);


    }

    ///UNIT TEST which implies ia ma testing for a particular function

    function testDepositAndWithdrawal() public {
        vm.prank(mamba);
        vault.deposit{value: 1 ether}();
        assertEq(vault.balancesOfUser(mamba), 1 ether);
        assertEq(vault.totalAssets(), 1 ether);

        //withdraw  1 ether --> expect 0.99 payout (1% fees)
        vm.prank(mamba);
        vault.withdrawal(1 ether);

        assertEq(vault.balancesOfUser(mamba), 0);
        assertEq(vault.totalAssets(), 0);
        assertEq(mamba.balance, 9 ether + 0.99 ether); //got money back minus fee
    }

    //FUZZ TESTING

    function testFuzz_DepositWithdraw (uint256 amount) public {
        vm.assume(amount > 0 && amount < 1); //ignoring bad ranges.
    }
}