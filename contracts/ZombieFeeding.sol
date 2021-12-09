//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

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
  // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  // KittyInterface kittyContract = KittyInterface(ckAddress);
  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(block.timestamp + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) {
    return (_zombie.readyTime <= block.timestamp);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public payable {
    //make sure we are the owner of the zombie
    require(msg.sender == zombieToOwner[_zombieId]);
    // get the zombie locally
    Zombie storage myZombie = zombies[_zombieId];
    //make sure that the DNA is not longer than 16 digits
    _targetDna = _targetDna % dnaModulus;
    // create a new DNA based on the target and the "current" zombie'DNA
    uint newDna = (myZombie.dna + _targetDna) / 2;

    //can't directly pass strings to keccak256
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
      //Assume newDna is 334455. Then newDna % 100 is 55, so newDna - newDna % 100 is 334400. Finally add 99 to get 334499.
    }

    // create a new zombie
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    // assign the value of genes to kittyDna
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // And modify function call here:
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}
