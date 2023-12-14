// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/CryptoComposite.sol";
import "../src/BioAttributes.sol";

contract CryptoCompositeScript is Script {
    uint256 tokenId = 1;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        BioAttributes attr = new BioAttributes();
        CryptoComposite cc = new CryptoComposite(attr);

        uint256 seed = uint(
            keccak256(
                abi.encodePacked(block.timestamp, block.prevrandao, "23238231")
            )
        );
        string memory name = attr.getProjectName(seed);
        string memory role = attr.getProjectRole(seed);
        console2.log("role", role);
        console2.log("project", name);

        string memory svg = cc.generateHTML(seed);
        // console2.logString(svg);
    }
}
