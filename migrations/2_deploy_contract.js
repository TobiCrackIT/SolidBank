const SolidBank = artifacts.require("SolidBank");

module.exports = async function(deployer) {
  await deployer.deploy(SolidBank);
  await SolidBank.deployed();
  
};
