// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract medicalProfContract{
    address public Prof;
    uint public reportCount;
    mapping(uint=>string) private reportsTrack;
    mapping(string=>string) private reportComments;
    mapping(string=>address) private reportPatients;

    constructor(address prof){
        Prof = prof;
    }

    modifier onlyProf{
        require(msg.sender==Prof,"only authorised professionals can access");
        _;
    }

    function getReports(uint index) public view onlyProf returns(string memory){
        return reportsTrack[index];

    }

    function addComments(string memory comments, string memory report) public onlyProf{
        reportComments[report] = comments;
    }


    function addReports(string memory report,address patient) public {
        reportsTrack[reportCount] = report;
        reportCount+=1;
        reportPatients[report] = patient;

    }

}
