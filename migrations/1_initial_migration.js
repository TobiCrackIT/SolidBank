const Migrations = artifacts.require("SolidBank");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
