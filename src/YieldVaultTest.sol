//Spdx-License-Identifier: MIT

pragma solidity ^0.8.20;

contract YieldVault {
    uint256 public totalAssets;
    uint256 public protocolFee; // 100 1%
    mapping (address => uint256 ) public balancesOfUser;
    uint256 public constant  FEE_DENOMINATOR = 1000;


    constructor(uint256 _protocolFee) {
        protocolFee = _protocolFee;
    }

    //deposit function
    //@param  the amount to be deposited when trying to interact with this protocol
    function deposit() external payable {
        require( msg.value > 0, "Sould deposit amount greater than a zero amount");
        balancesOfUser[msg.sender] += msg.value;
        totalAssets += msg.value;
    }

    // the function that allows for a user to withdraw the amount they have deposited
    //@params the amount of the deposited funds to be withdrawn
    function withdrawal(uint256 _amount) external {
        require(balancesOfUser[msg.sender] >= _amount, "Insufficient balance");
        //ccalculating the protocol fee

        uint256 fee = (_amount * protocolFee) / FEE_DENOMINATOR;
        uint256 payout = _amount - fee;

        //Using the check effect interaction pattern
        balancesOfUser[msg.sender] -= _amount;
        totalAssets -= _amount;


        payable(msg.sender).transfer(payout);
    }

    //the function the view the amount the user has left in the protocol
    //@param the address of the user
    // function balanceOf(address _user) external view returns (uint256) {
    //     return balancesOfUser(_user);
    // }
}