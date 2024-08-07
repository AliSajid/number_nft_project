// SPDX-FileCopyrightText: 2024 Ali Sajid Imami
//
// SPDX-License-Identifier: MIT
//
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ColoredNumbers is ERC721, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("ColoredNumbers", "CLN")
        Ownable(initialOwner)
    {}

    mapping(string => uint8) existingURIs;

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function isContentOwned(string memory uri) public view returns (bool) {
        return existingURIs[uri] == 1;
    }

    function payToMint(
      address recipient,
      string memory metadataURI
    ) public payable returns (uint256) {

      require(existingURIs[metadataURI] != 1, "This NFT has already been minted");
      require(msg.value >= 0.05 ether, "Insufficient funds to mint NFT");

      uint256 newItemId = _nextTokenId++;
      existingURIs[metadataURI] = 1;

      _safeMint(recipient, newItemId);
      _setTokenURI(newItemId, metadataURI);

      return newItemId;
    }

    function count() public view returns (uint256) {
      return _nextTokenId;
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
