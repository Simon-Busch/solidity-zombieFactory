const hre = require("hardhat");

const main = async () => {
  console.log("hello")
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log('Deploying contracts with account: ', deployer.address);
  console.log('Account balance: ', accountBalance.toString());

  const ZombieFactoryContract = await hre.ethers.getContractFactory('ZombieFactory');
  const ZombieContract = await ZombieFactoryContract.deploy();
  await ZombieContract.deployed();

  console.log("Contract deployed to:", ZombieContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();