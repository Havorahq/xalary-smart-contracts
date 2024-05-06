// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./FixedRateAgreement.sol";

// what's the use of this contract
// this contract is the entry point for the entire system
// this contract deploys the agreement smart contracts

contract Xalary {
    function deployFixedRateAgreement()
        public
        pure
        returns (
            // string memory _employerId,
            // string memory _employeeId,
            // address _employerAddress,
            // address _currency,
            // uint256 _fixedPayment
            bool
        )
    {
        // FixedRateAgreement newAgreement = FixedRateAgreement(
        //         _employerId,
        //         _employeeId,
        //         _employerAddress,
        //         _currency,
        //         _fixedPayment
        // );
        // FixedRateAgreement newAgreement = FixedRateAgreement(
        // _employerId,
        // _employeeId,
        // _employerAddress,
        // _currency,
        // _fixedPayment
        // );

        return true;
    }
}
