// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "solmate/src/tokens/ERC721.sol"; // todo: replace with OZ
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "./BioAttributes.sol";
import "./SvgRender.sol";

contract CryptoComposite is ERC721("CryptoComposite", "CTCPS") {
    uint256 totalSupply = 0;

    mapping(address => uint256) addressToBioSeed;
    mapping(address => uint256) addressToPfpSeed;
    mapping(uint256 => address) idToAddress;

    BioAttributes attributes;
    SvgRender svgRender;
    
    constructor(BioAttributes _attributes, SvgRender _svgRender){
        attributes = _attributes;
        svgRender = _svgRender;
    }

    function mint(uint256 bioSeed, uint256 pfpSeed) public returns(uint256){
        // todo: mint constraints
        _safeMint(msg.sender, totalSupply);
        idToAddress[totalSupply] = msg.sender;
        addressToBioSeed[msg.sender] = bioSeed;
        addressToPfpSeed[msg.sender] = pfpSeed;
        totalSupply++; // todo: replace with OZ
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        address owner = idToAddress[tokenId];
        uint256 bioSeed = addressToBioSeed[owner];
        uint256 pfpSeed = addressToPfpSeed[owner];
        string memory svg = svgRender.getSvg(pfpSeed);
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Crypto Composite #',
                        toString(tokenId),
                        '" "description": "...", "image_data": "',
                        svg,
                        '", ',
                        getAttributes(owner, bioSeed),
                        "}"
                    )
                )
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    function getAttributes(address owner, uint256 bioSeed) public view returns(string memory){

    }
   
    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

}

library Base64 {
    bytes internal constant TABLE =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(input, 0x3F))), 0xFF)
                )
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}