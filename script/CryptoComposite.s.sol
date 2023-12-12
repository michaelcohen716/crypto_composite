// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/CryptoComposite.sol";

contract CryptoCompositeScript is Script {
    uint256 tokenId = 1;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        CryptoComposite cc = new CryptoComposite();
        uint256 seed = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao)));
        string memory svg = cc.generateHTML(seed);
        console2.logString(svg);
    }
}
