// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract patientContract{

    address public Patient;
    string private patientDetais;
    mapping(address=> bool) public dataAccess;
    mapping(string=>uint) private patientDocs;
    uint public docsCount;
    mapping(uint=>string) private retriveDocs;

    modifier onlyPatient(){
        require(msg.sender==Patient,"can only be accessed by owner patient");
        _;
    }

    modifier authorisedAccess(){
        require(dataAccess[msg.sender],"not authorised");
        _;
    }

    constructor(string memory dataHash, address patient){
        Patient = patient;
        patientDetais = dataHash;
    }

    function getPatientDetails() public authorisedAccess onlyPatient view returns(string memory){
        return patientDetais;
    }

    function changePatientDetails(string memory newDetails) public authorisedAccess onlyPatient(){
        patientDetais = newDetails;
    }

    function insertPatientDocs(string memory data) public authorisedAccess onlyPatient{
        require(patientDocs[data]==0,"docs alrready exists");
        patientDocs[data] = block.timestamp;
        retriveDocs[docsCount] = data;
        docsCount+=1;
    }

    function getDocTimeStamp(string memory data) public authorisedAccess onlyPatient view returns(uint){
        require(patientDocs[data]!=0,"docs doesnt exits");
        return patientDocs[data];

    }

    function provideAccess(address requester) public onlyPatient{
        dataAccess[requester] = true;
    }






    
    
}
