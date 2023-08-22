// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "./patient1.sol";
import "./doctor1.sol";
import "./medical1.sol";

contract factoryContract{

    mapping(address=>address) private patientContracts;
    mapping(address=>address) private doctorsHospitals;
    mapping(address=>address) private medicalProf;
    mapping(uint=>address) private profTracks;

    uint public profCount;
    //this value is also stored in database along with a curr value

    function createPatient(string memory patientData) public{
        address newPatient = address(new patientContract(patientData,msg.sender,address(this)));
        patientContracts[msg.sender] = newPatient;


    }

    function createDoctor(string memory docDetails)public {
        address newDoctor = address(new doctorContract(msg.sender,docDetails));
        doctorsHospitals[msg.sender] = newDoctor;
    }

    function createProf() public {
        address newProf=  address(new medicalProfContract(msg.sender));
        medicalProf[msg.sender] = newProf;
        profTracks[profCount] = msg.sender;
        profCount+=1;

    }

    function getMedicalProf(uint index) public view returns(address){
        return medicalProf[profTracks[index]];
    }

    function getPatientContract(address patient) public view returns(address){
        return patientContracts[patient];
    }

    function getDoctor(address doctor) public view returns(address){
        return doctorsHospitals[doctor];
    }

    function getMedicalProf(address prof) public view returns(address){
        return medicalProf[prof];
    }

    


}
