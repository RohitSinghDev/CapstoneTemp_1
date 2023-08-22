// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract doctorContract{

    address public Doctor;
    string private doctorDetails;
    mapping(address=>bool) public patientList;
    uint public patientCount;
    mapping(uint=>address) public patientTrack;
    

    constructor(address doctor,string memory docDetails){
        Doctor = doctor;
        doctorDetails = docDetails;
    }

    // first doctor will save the patient hash
    function recordPatient(address patient) public {
        patientList[patient] = true;
        patientTrack[patientCount]  = patient;
        patientCount+=1;

    }


  


    
    
}
