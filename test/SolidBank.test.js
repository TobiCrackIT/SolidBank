const { expect, assert } = require("chai");
const { ethers } = require("hardhat");


const SolidBank = artifacts.require("SolidBank");

contract('SolidBank', function(accounts){

    var user;


    it("should assert true", async function () {
        await SolidBank.deployed();
        return assert.isTrue(true);
    });

    it("should have a real address after successful deployment", async function () {
        const solidBank = await SolidBank.deployed();
        assert(solidBank.address !=='');
    });


    it("total contract balance should equal to 0", async function () {
        const solidBank = await SolidBank.deployed();

        let contractBalance = await solidBank.getContractBalance();
        assert(contractBalance == 0);
    });

    it("balance should equal to 0", async function () {
        user= accounts[1];
        const solidBank = await SolidBank.deployed();

    
        let balance = await solidBank.getBalance(user);
        assert(balance == 0);
    });

});