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

    
}