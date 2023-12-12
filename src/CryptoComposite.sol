// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

contract CryptoComposite {
    function getColor(
        uint256 seed,
        uint256 colorIndex
    ) public pure returns (string memory) {
        // facial lines
        string[2] memory indices1 = ["000000", "36445f"];
        if (colorIndex == 1) return indices1[(seed % 8765) % indices1.length];

        if (colorIndex == 2) return "2bafff";
        if (colorIndex == 3) return "12dcfe";
        if (colorIndex == 4) return "1c74ee";
        if (colorIndex == 5) return "134fa3";

        // skin/back #2
        if (colorIndex == 6) return "#c68642";

        // background/skin
        string[5] memory indices7 = [
            "e6ebe6",
            "8d5524",
            "e0ac69",
            "f1c27d",
            "ffdbac"
        ];
        if (colorIndex == 7) return indices7[(seed % 4321) % indices7.length];

        return "ffffff";
    }

    function getSvg(uint256 tokenId) public view returns (string memory svg) {}

    function generateHTML(uint256 seed) public view returns (string memory) {
        uint16[576] memory grid = generateGrid(seed);
        string
            memory html = '<div style="font-size:0; width:288px; height:288px;"><style>span{display:inline-block;width:12px;height:12px;}</style>';
        for (uint256 i = 0; i < 576; i++) {
            html = string(
                abi.encodePacked(
                    html,
                    '<span style="background-color:#',
                    getColor(seed, grid[i]),
                    ';"></span>'
                )
            );
        }
        html = string(abi.encodePacked(html, "</div>"));
        return html;
    }

    function generateGrid(
        uint256 seed
    ) public pure returns (uint16[576] memory grid) {
        grid = getFaceOutline(0, grid);
        grid = getHair(0, seed, grid);
        grid = getNose(0, grid);
        grid = getEyes(seed, grid);
        grid = getEars(0, grid);
        grid = getMouth(0, grid);

        grid = getSkin(grid);
    }

    function getSkin(
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        for (uint i = 0; i < grid.length; i++) {
            if (i / 24 > 8 && i / 24 < 21) {
                if (i % 24 > 5 && i % 24 < 18) {
                    if (grid[i] == 0) {
                        grid[i] = 7;
                    }
                }
            }
        }
        return grid;
    }

    function getHair(
        uint256 faceVersion,
        uint256 seed,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint256 version = (seed % 3498) % 2;

        uint8[54] memory hair0 = [
            58,
            81,
            82,
            83,
            105,
            106,
            107,
            108,
            109,
            110,
            111,
            112,
            127,
            128,
            129,
            130,
            131,
            132,
            133,
            134,
            135,
            136,
            150,
            151,
            152,
            153,
            154,
            155,
            156,
            157,
            158,
            159,
            160,
            161,
            174,
            175,
            176,
            177,
            178,
            179,
            180,
            181,
            182,
            183,
            184,
            185,
            200,
            201,
            202,
            204,
            205,
            206,
            207,
            209
        ];

        uint8[74] memory hair1 = [
            33,
            34,
            35,
            36,
            38,
            39,
            53,
            55,
            56,
            57,
            58,
            59,
            60,
            61,
            62,
            63,
            64,
            65,
            //
            77,
            78,
            79,
            80,
            81,
            82,
            83,
            84,
            85,
            86,
            87,
            88,
            89,
            90,
            //
            101,
            102,
            103,
            104,
            105,
            106,
            107,
            110,
            111,
            112,
            113,
            114,
            115,
            //
            124,
            125,
            126,
            127,
            128,
            129,
            130,
            131,
            132,
            133,
            134,
            135,
            136,
            137,
            138,
            139,
            // 
            148,
            149,
            162,
            163,
            //
            173,
            186,
            // 
            196,
            197,
            210,
            211,
            // 
            219,
            220,
            234
        ];

        if (faceVersion == 0) {
            if (version == 0 || version == 1) {
                for (uint i = 0; i < hair0.length; i++) {
                    uint8 rand = uint8(
                        uint256(keccak256(abi.encodePacked(seed, i)))
                    ) % 100;
                    if (hair0[i] < 151) {
                        grid[hair0[i]] = 2;
                    } else {
                        grid[hair0[i]] = (rand < 90) ? 3 : 2;
                    }
                }
            }
            if (version == 1) {
                for (uint i = 0; i < hair1.length; i++) {
                    grid[hair1[i]] = 2;
                }
            }
        }
        return grid;
    }

    function getFaceOutline(
        uint256 seed,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint16[71] memory faceOutline0 = [
            34,
            57,
            59,
            80,
            84,
            85,
            86,
            87,
            88,
            103,
            104,
            113,
            125,
            126,
            137,
            138,
            149,
            162,
            173,
            186,
            197,
            198,
            199,
            203,
            208,
            210,
            221,
            224,
            225,
            226,
            228,
            229,
            230,
            231,
            233,
            234,
            245,
            258,
            268,
            269,
            282,
            283,
            291,
            308,
            315,
            332,
            340,
            341,
            354,
            355,
            365,
            378,
            389,
            402,
            414,
            426,
            438,
            450,
            462,
            474,
            487,
            488,
            489,
            497,
            514,
            515,
            516,
            517,
            518,
            519,
            520
        ];

        if (seed == 0) {
            // todo: fix
            for (uint i = 0; i < faceOutline0.length; i++) {
                grid[faceOutline0[i]] = 1;
            }
        }
        return grid;
    }

    function getNose(
        uint256 seed,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint256 version = (seed % 4334) % 2;

        uint16[6] memory nose0 = [347, 348, 349, 371, 373, 396];
        uint16[4] memory nose1 = [347, 348, 349, 372];

        // note: right now, this could be done with same
        // for loop, but keeping it separate for optionality
        if (version == 0) {
            for (uint i = 0; i < nose0.length; i++) {
                grid[nose0[i]] = 1;
            }
        } else if (version == 1) {
            for (uint i = 0; i < nose1.length; i++) {
                grid[nose1[i]] = 1;
            }
        }

        return grid;
    }

    function getEyes(
        uint256 seed,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint256 version = (seed % 5432) % 2;

        uint16[8] memory rightEye0 = [272, 295, 296, 298, 320, 273, 297, 321];
        uint16[8] memory leftEye0 = [280, 302, 304, 305, 328, 279, 303, 327];

        uint16[7] memory rightEye1 = [272, 296, 274, 298, 321, 273, 297];
        uint16[7] memory leftEye1 = [278, 302, 280, 304, 327, 279, 303];

        if (version == 0) {
            for (uint i = 0; i < rightEye0.length; i++) {
                if (i < 4) {
                    grid[rightEye0[i]] = 2;
                    grid[leftEye0[i]] = 2;
                } else if (i < 5) {
                    grid[rightEye0[i]] = 3;
                    grid[leftEye0[i]] = 3;
                } else if (i < 7) {
                    grid[rightEye0[i]] = 4;
                    grid[leftEye0[i]] = 4;
                } else {
                    grid[rightEye0[i]] = 5;
                    grid[leftEye0[i]] = 5;
                }
            }
        } else if (version == 1) {
            for (uint i = 0; i < rightEye1.length; i++) {
                if (i < 4) {
                    grid[rightEye1[i]] = 2;
                    grid[leftEye1[i]] = 2;
                } else if (i < 6) {
                    grid[rightEye1[i]] = 3;
                    grid[leftEye1[i]] = 3;
                } else {
                    grid[rightEye1[i]] = 4;
                    grid[leftEye1[i]] = 4;
                }
            }
        }
        return grid;
    }

    function getEars(
        uint256 index,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint16[8] memory ears1 = [292, 293, 316, 317, 306, 307, 330, 331];
        for (uint i = 0; i < ears1.length; i++) {
            grid[ears1[i]] = 5;
        }

        return grid;
    }

    function getMouth(
        uint256 seed,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint256 version = (seed % 6765) % 2;

        uint16[7] memory mouth0 = [400, 423, 446, 467, 468, 469, 470];
        uint16[8] memory mouth1 = [442, 446, 467, 468, 469, 443, 444, 445];

        if (version == 0) {
            for (uint i = 0; i < mouth0.length; i++) {
                grid[mouth0[i]] = 1;
            }
        } else if (version == 1) {
            for (uint i = 0; i < mouth1.length; i++) {
                if (i < 5) {
                    grid[mouth1[i]] = 1;
                } else {
                    grid[mouth1[i]] = 2;
                }
            }
        }
        return grid;
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

    function _randomColor(uint256 seed) internal pure returns (string memory) {
        bytes16 hexChars = "0123456789ABCDEF";
        bytes memory color = new bytes(6);
        for (uint256 i = 0; i < 6; i++) {
            color[i] = hexChars[uint8(seed >> (i * 4)) & 0xf];
        }
        return string(color);
    }
}
