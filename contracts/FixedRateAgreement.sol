// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Agreement.sol";

contract FixedRateAgreement is Agreement {
    enum PaymentStatus {
        Unpaid,
        Paid
    }

    uint256 fixedPayment;
    PaymentStatus public paymentStatus = PaymentStatus.Unpaid;

    event FixedPaymentMade(
        address indexed employeeAddress,
        address indexed employerAddress
    );

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

    function transferTokens(address _to, uint256 _amount) internal {
        // Load the USDT contract
        IERC20 token = IERC20(currency);

        // Transfer USDT to the given address
        require(token.transfer(_to, _amount), "Token transfer failed");
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
        transferTokens(paymentAddress, fixedPayment);

        paymentStatus = PaymentStatus.Paid;
        agreementStatus = AgreementStatus.Closed;
        emit PaymentMade(address(this));
        emit FixedPaymentMade(paymentAddress, employerAddress);
        return;
    }
}
