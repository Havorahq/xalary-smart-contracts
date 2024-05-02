//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "./FixedRateAgreement.sol";

import "hardhat/console.sol";

contract AgreementFactory {
    FixedRateAgreement[] public fixedRateAgreements;
    uint256 public numOfAgreements = 0;

    function createNewFixedRateAgreement(
        string memory _employerId,
        string memory _employeeId,
        address _employerAddress,
        address _currency,
        uint256 _fixedPayment
    ) public {
        console.log("deploying a fixed rate agreement");

        FixedRateAgreement agreement = new FixedRateAgreement(
            _employerId,
            _employeeId,
            _employerAddress,
            _currency,
            _fixedPayment
        );
        console.log("before the push");
        fixedRateAgreements.push(agreement);
        numOfAgreements = numOfAgreements + 1;
        console.log(address(agreement), "the new contract adress");
        return;
    }

    function getNumberOfFixedRateAgreements() public view returns (uint256) {
        return fixedRateAgreements.length;
    }
}
