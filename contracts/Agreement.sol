// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IERC20 {
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
}

contract Agreement {
    enum AgreementStatus {
        Pending,
        Active,
        Suspended,
        Cancelled, // a contract that has been cancelled cannot be reactivated
        Closed
    }

    string public employerId;
    string public employeeId;
    address public employerAddress;
    address public paymentAddress; // the wallet address used by the employer to accept payments
    address public currency; // the stable coin used for payment
    AgreementStatus public agreementStatus;
    string public contractType;

    event PaymentMade(address indexed agreementAddress);

    // constructor
    constructor(
        string memory _employerId,
        string memory _employeeId,
        address _employerAddress,
        address _currency,
        string memory _contractType
    ) {
        employerId = _employerId;
        employeeId = _employeeId;
        employerAddress = _employerAddress;
        currency = _currency;
        agreementStatus = AgreementStatus.Pending;
        contractType = _contractType;
    }

    modifier onlyEmployer() {
        require(
            msg.sender == employerAddress,
            "You are not allowed to carry out this action"
        );
        _;
    }

    // cancelContract
    function cancel() public onlyEmployer {
        require(
            agreementStatus != AgreementStatus.Cancelled,
            "This contract has already been cancelled"
        );
        agreementStatus = AgreementStatus.Cancelled;
        return;
    }

    // suspendContract
    function suspend() public onlyEmployer {
        require(
            agreementStatus != AgreementStatus.Cancelled,
            "This contract has already been cancelled"
        );
        require(
            agreementStatus != AgreementStatus.Closed,
            "This contract has already been closed"
        );
        agreementStatus = AgreementStatus.Suspended;
        return;
    }

    // close the contract
    function close() public onlyEmployer {
        require(
            agreementStatus != AgreementStatus.Cancelled,
            "This contract has already been cancelled"
        );

        agreementStatus = AgreementStatus.Closed;
        return;
    }

    // changePaymentAddress

    // employee enter contract
    function employeeEnterContract(address _paymentAddress) public {
        require(
            agreementStatus == AgreementStatus.Pending,
            "This contract is no longer pending"
        );

        paymentAddress = _paymentAddress;
        agreementStatus = AgreementStatus.Active;
        return;
    }

    function withdrawFunds() public view onlyEmployer {
        // this contract is a safety contract used by the employer to remove funds from the agreement contract
    }
}
