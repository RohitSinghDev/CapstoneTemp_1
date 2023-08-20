// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "./patient1.sol";

contract factoryContract{

    mapping(address=>address) private patientContracts;
    mapping(address=>address) private doctorsHospitals;

    function createPatient(string memory patientData) public{
        address newPatient = address(new patientContract(patientData,msg.sender));
        patientContracts[msg.sender] = newPatient;


    }

    


}
