pragma solidity ^0.8.0;

import "./ZombieAttack.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ERC721.sol";


abstract contract ZombieOwnership is ZombieAttack, ERC721 {

  mapping (uint => address) zombieApprovals;

  function balanceOf(address _owner) override public view returns (uint256) {
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) override public view returns (address) {
    return zombieToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to]++; 
    ownerZombieCount[_from]--;
    zombieToOwner[_tokenId] = _to; // re-assign the zombie to new owner
    emit Transfer(_from, _to, _tokenId); // from ERC721
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) override external payable {
    //make sure that only the owner or the approved address of a token/zombie can transfer it.
    require (zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender, "you can't transfer this zombie");
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) override external payable onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _approved; // set approved address for a specific zombie
    emit Approval(msg.sender, _approved, _tokenId); // from ERC721
  }
}

