const hre = require("hardhat");

const main = async () => {
  const ZombieFactory = await hre.ethers.getContractFactory("ZombieFactory");
  const ZombieFactoryContract = await ZombieFactory.deploy();
  await ZombieFactoryContract.deployed();
  console.log("Contract ZombieFactoryContract deployed to:", ZombieFactoryContract.address);

  const ZombieOwnership = await hre.ethers.getContractFactory("ZombieOwnership");
  const ZombieOwnershipContract = await ZombieOwnership.deploy();
  await ZombieOwnershipContract.deployed();
  console.log("Contract ZombieOwnershipContract deployed to:", ZombieOwnershipContract.address);

  const ZombieHelper = await hre.ethers.getContractFactory("ZombieHelper");
  const ZombieHelperContract = await ZombieHelper.deploy();
  await ZombieHelperContract.deployed();
  console.log("Contract ZombieHelperContract deployed to:", ZombieHelperContract.address);

  const ZombieFeeding = await hre.ethers.getContractFactory("ZombieFeeding");
  const ZombieFeedingContract = await ZombieFeeding.deploy();
  await ZombieFeedingContract.deployed();
  console.log("Contract ZombieFeedingContract deployed to:", ZombieFeedingContract.address);

  const ZombieAttack = await hre.ethers.getContractFactory("ZombieAttack");
  const ZombieAttackContract = await ZombieAttack.deploy();
  await ZombieAttackContract.deployed();
  console.log("Contract ZombieAttackContract deployed to:", ZombieAttackContract.address);
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