//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "./PayAsYouGoAgreement.sol";
import "./FixedRateAgreement.sol";

import "hardhat/console.sol";

contract AgreementFactory {
    FixedRateAgreement[] public fixedRateAgreements;
    PayAsYouGoAgreement[] public payAsYouGoAgreements;

    event FixedRateAgreementDeployed(address indexed contractAddress);
    event PayAsYoGoAgreementDeployed(address indexed contractAddress);

    function createNewFixedRateAgreement(
        string memory _employerId,
        string memory _employeeId,
        address _employerAddress,
        address _currency,
        uint256 _fixedPayment
    ) public returns (address) {
        FixedRateAgreement agreement = new FixedRateAgreement(
            _employerId,
            _employeeId,
            _employerAddress,
            _currency,
            _fixedPayment
        );
        fixedRateAgreements.push(agreement);

        console.log(address(agreement), "the agreement contract");

        emit FixedRateAgreementDeployed(address(agreement));
        return address(agreement);
    }

    function getNumberOfFixedRateAgreements() public view returns (uint256) {
        return fixedRateAgreements.length;
    }

    function createNewPayAsYouGoAgreement(
        string memory _employerId,
        string memory _employeeId,
        address _employerAddress,
        address _currency,
        uint256 _monthlyPayment
    ) public {
        PayAsYouGoAgreement agreement = new PayAsYouGoAgreement(
            _employerId,
            _employeeId,
            _employerAddress,
            _currency,
            _monthlyPayment
        );

        payAsYouGoAgreements.push(agreement);

        emit PayAsYoGoAgreementDeployed(address(agreement));
    }

    function getNumberOfPayAsYouGoAgreements() public view returns (uint256) {
        return payAsYouGoAgreements.length;
    }
}
