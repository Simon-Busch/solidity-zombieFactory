const hre = require("hardhat");

const main = async () => {
  const ZombieFactory = await hre.ethers.getContractFactory("ZombieFactory");
  const ZombieFactoryContract = await ZombieFactory.deploy();
  await ZombieFactoryContract.deployed();
  console.log("Contract ZombieFactoryContract deployed to:", ZombieFactoryContract.address);
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