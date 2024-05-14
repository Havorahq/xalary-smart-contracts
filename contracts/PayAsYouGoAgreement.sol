// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Agreement.sol";

contract PayAsYouGoAgreement is Agreement {
    enum PaymentStatus {
        Unpaid,
        Paid
    }

    struct Payment {
        uint256 amount;
        address payeeAddress;
        // date
    }

    event PayAsYouGoPaymentMade(
        address indexed employeeAddress,
        address indexed employerAddress
    );

    Payment[] public payments;

    uint256 monthlyPayment;
    // payment history

    constructor(
        string memory _employerId,
        string memory _employeeId,
        address _employerAddress,
        address _currency,
        uint256 _monthlyPayment
    )
        Agreement(
            _employerId,
            _employeeId,
            _employerAddress,
            _currency,
            "pay as you go"
        )
    {
        monthlyPayment = _monthlyPayment;
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
        // send monthly payment to the employee's wallet address
        transferTokens(paymentAddress, monthlyPayment);
        emit PaymentMade(address(this));
        emit PayAsYouGoPaymentMade(paymentAddress, employerAddress);
        // store payment details and add payment event
        return;
    }

    function setMonthlyPayments(
        uint256 newMonthlyPayment
    ) public onlyEmployer {}
}
