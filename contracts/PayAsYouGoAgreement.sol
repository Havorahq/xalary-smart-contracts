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

    // sendPayment
    function sendPayment() public view onlyEmployer {
        require(
            agreementStatus == AgreementStatus.Active,
            "This contract is no longer active"
        );
        // send monthly payment to the employee's wallet address
        return;
    }

    function setMonthlyPayments(
        uint256 newMonthlyPayment
    ) public onlyEmployer {}
}
