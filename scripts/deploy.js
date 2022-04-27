const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

async function main() {

    const contract = await ethers.getContractFactory('SolidBank');

    const deployedContract = await contract.deploy();

    console.log("Contract Address ", deployedContract.address);

}

main()
    .then(() => process.exit(0))
    .catch((e) => {
        console.error(error);
        process.exit(1);
    }
    );