// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Agreement.sol";

contract FixedRateAgreement is Agreement {
    enum PaymentStatus {
        Unpaid,
        Paid
    }

    uint256 fixedPayment;
    PaymentStatus paymentStatus = PaymentStatus.Unpaid;

    constructor(
        string memory _employerId,
        string memory _employeeId,
        address _employerAddress,
        address _currency,
        uint256 _fixedPayment
    )
        Agreement(
            _employerId,
            _employeeId,
            _employerAddress,
            _currency,
            "fixed rate"
        )
    {
        fixedPayment = _fixedPayment;
    }

    // sendPayment
    function sendPayment() public onlyEmployer {
        require(
            agreementStatus == AgreementStatus.Active,
            "This contract is no longer active"
        );
        require(
            paymentStatus != PaymentStatus.Paid,
            "Payment has already been sent"
        );
        // send the money to the employees wallet address
        paymentStatus = PaymentStatus.Paid;
        agreementStatus = AgreementStatus.Closed;
        return;
    }
}
