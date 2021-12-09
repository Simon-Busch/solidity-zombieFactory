//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
// pragma solidity >=0.5.0 <0.6.0;
import "hardhat/console.sol";
import "./ZombieFactory.sol";

interface KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  //Crypto kitties address
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public view {
    //make sure we are the owner of the zombie
    require(msg.sender == zombieToOwner[_zombieId]);
    // get the zombie locally
    Zombie storage myZombie = zombies[_zombieId];
    //make sure that the DNA is not longer than 16 digits
    _targetDna = _targetDna % dnaModulus;
    // create a new DNA based on the target and the "current" zombie'DNA
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // create a new zombie
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // assign the value of genes to kittyDna
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // And modify function call here:
    feedAndMultiply(_zombieId, kittyDna);
  }

}
