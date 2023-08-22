// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract patientContract{

    address public Factory;
    address public Patient;
    string private patientDetais;
    mapping(address=> bool) public dataAccess;
    mapping(string=>uint) private patientDocs;
    uint public docsCount;
    mapping(uint=>string) private retriveDocs;
    mapping(string=>bool) public isValidated;

    modifier onlyPatient(){
        require(msg.sender==Patient,"can only be accessed by owner patient");
        _;
    }

    modifier authorisedAccess(){
        require(dataAccess[msg.sender],"not authorised");
        _;
    }

    constructor(string memory dataHash, address patient, address factory){
        Patient = patient;
        patientDetais = dataHash;
        Factory = factory;
        dataAccess[Patient] = true;
    }

    function getPatientDetails() public authorisedAccess view returns(string memory){
        return patientDetais;
    }

    function changePatientDetails(string memory newDetails) public authorisedAccess{
        patientDetais = newDetails;
    }

    function insertPatientDocs(string memory data, uint curr) public authorisedAccess{
        require(patientDocs[data]==0,"docs alrready exists");
        patientDocs[data] = block.timestamp;
        retriveDocs[docsCount] = data;
        docsCount+=1;
        //send for validation
        // increment curr value(in mongodb) after inserting each patient docs
        (bool success, bytes memory returnedData) = address(Factory).call(abi.encodeWithSignature("getMedicalProf(uint256)", curr));
        require(success,"some error");
        address currProf = abi.decode(returnedData, (address));
        (bool success2, ) = address(currProf).call(abi.encodeWithSignature("addReports(string,address)", data,Patient));
        require(success2,"some error");

        





    }

    function getDocTimeStamp(string memory data) public authorisedAccess view returns(uint){
        require(patientDocs[data]!=0,"docs doesnt exits");
        return patientDocs[data];

    }

    function provideAccess(address requester) public onlyPatient{
        dataAccess[requester] = true;
    }

    function getPatientDocs(uint index) public authorisedAccess view returns(string memory){
        return retriveDocs[index];
    }






    
    
}
