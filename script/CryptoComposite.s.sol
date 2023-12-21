// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/CryptoComposite.sol";
import "../src/BioAttributes.sol";
import "../src/SvgRender.sol";

contract CryptoCompositeScript is Script {
    uint256 tokenId = 1;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        SvgRender svg = new SvgRender();
        BioAttributes attr = new BioAttributes();
        CryptoComposite cc = new CryptoComposite(attr, svg);

        console2.log(address(svg));
        console2.log(address(attr));
        console2.log(address(cc));

        // uint256 seed = uint(
        //     keccak256(
        //         abi.encodePacked(block.timestamp, block.prevrandao, "ada33eds")
        //     )
        // );
        // console2.log('script seed', seed);
        // string memory sector = attr.getSector(seed);
        // string memory name = attr.getProjectName(seed);
        // string memory role = attr.getProjectRole(seed);
        // console2.log("sector", sector);
        // console2.log("role", role);
        // console2.log("project", name);

        // string memory svgStr = svg.getSvg(seed);
        // console2.logString(svgStr);
    }
}
