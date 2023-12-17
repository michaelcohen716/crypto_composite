// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface ISvgRender {
    function getSvg(uint256 pfpSeed) external view returns(string memory);
}

contract SvgRender {
    function getColor(
        uint256 seed,
        uint256 colorIndex
    ) public pure returns (string memory) {
        // facial lines
        //[black, blue-gray]
        string[2] memory indices1 = ["000000", "36445f"];
        if (colorIndex == 1) return indices1[(seed % 8765) % indices1.length];

        // hair1, eye1
        // [purple, light brown, orange, blonde, red, grey, yellow]
        string[7] memory indices2 = ["8e44ad", "a67f59", "e67e22", "f0e2be", "9f1d35", "d0d0d0", "f1c40f"];
        if (colorIndex == 2) return indices2[(seed % 8443) % indices2.length];

        // hair2 (complements), eye2
        // [greenish, blueish, blue, dark blue, teal, dark grey, blue]
        string[7] memory indices3 = ["71bb52", "5980a6", "1981dd", "0f1d41", "60e2ca", "2f2f2f", "0e3bf0"];
        if (colorIndex == 3) return indices3[(seed % 8443) % indices3.length];

        // eye3
        // [taupe, plum, sky blue, sunflower, mint, rose, coral]
        string[7] memory indices4 = ["c7a17a", "6b2d5c", "8fbcd4", "e3ac3d", "a1dbb2", "f7c6c7", "ff6f61"];
        if (colorIndex == 4) return indices4[(seed % 8443) % indices4.length];

        // ears, eye4
        // [amethyst, sunset, golden rod, skyline, mist, copper, slate]
        string[7] memory indices5 = ["9b59b6", "e74c3c", "f1c40f", "5dade2", "a6acaf", "ba4a00", "7f8c8d"];
        if (colorIndex == 5) return indices5[(seed % 5593) % indices5.length];

        // background/skin
        string[5] memory indices6 = [
            "e6ebe6",
            "8d5524",
            "e0ac69",
            "f1c27d",
            "ffdbac"
        ];
        if (colorIndex == 6) return indices6[(seed % 4321) % indices6.length];

        return "ffffff";
    }

    function getSvg(uint256 seed) public pure returns (string memory svg) {
        uint16[576] memory grid = generateGrid(seed);
        string memory header = '<svg style="background-color:#ffffff" viewBox="0 0 800 800" xmlns="http://www.w3.org/2000/svg">';
        string memory defs = '<defs></defs>';
        string memory style = '<style type="text/css"></style>';
        string memory rects = '';

        for (uint256 i = 0; i < 576; i++) {
            uint256 x = (i % 24) * 12;
            uint256 y = (i / 24) * 12;
            rects = string(abi.encodePacked(
                rects,
                '<rect x="', uintToString(x), '" y="', uintToString(y),
                '" width="12" height="12" fill="#', getColor(seed, grid[i]), '" />'
            ));
        }

        return string(abi.encodePacked(
            header,
            rects,
            '</svg>'
        ));
    }

    function generateGrid(
        uint256 seed
    ) public pure returns (uint16[576] memory grid) {
        grid = getFaceOutline(grid);
        grid = getEars(0, grid);
        grid = getHair(seed, grid);
        grid = getNose(0, grid);
        grid = getEyes(seed, grid);
        grid = getMouth(0, grid);
        grid = getSkin(grid);
    }

    function getFaceOutline(
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

        for (uint i = 0; i < faceOutline0.length; i++) {
            grid[faceOutline0[i]] = 1;
        }
        return grid;
    }

    function getEars(
        uint256 seed,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint16[8] memory ears1 = [292, 293, 316, 317, 306, 307, 330, 331];
        for (uint i = 0; i < ears1.length; i++) {
            grid[ears1[i]] = 5;
        }

        return grid;
    }

    function getHair(
        // uint256 faceVersion,
        uint256 seed,
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        uint256 version = 1;
        // uint256 version = (seed % 3498) % 4;

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

        uint16[41] memory hair2Outline = [
            // bottom left corner going up
            506, 482, 458, 434, 410, 386, 362, 338, 314, 290, 266, 242, 218, 194, 170,
            // top left corner going up,right and across
            147, 123, 124, 125, 100, 101, 102, 103, 77, 78, 79, 80, 81, 81, 82, 83, 58,
            // bottom left corner going right 
            507, 508, 509,
            // bottom right going up
            485, 461, 437, 413, 389, 365
        ];

        uint16[86] memory hair2Inner = [
            // filling from bottom up
            483, 484, 459, 460, 435, 436, 411, 412, 387, 388,
            363, 364, 339, 340, 315, 316, 291, 292, 267, 268,
            243, 244, 219, 220, 195, 196, 171, 172, 148,
            // starting middle left of forehead going across
            124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136,
            149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161,
            173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185,
            // filling in brow
            197, 200, 201, 202, 204, 205, 206, 207, 209,
            // filling in top
            104, 105, 106, 107, 108, 109, 110, 111, 112
            // 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112
        ];

        uint8[1] memory hair2Cleanup = [34];

        uint16[60] memory hair3Outline = [
            // bottom left corner going up
            364, 363, 339, 315, 314, 290, 266, 242, 218, 194,
            193, 169, 145, 146, 122, 123, 98, 99, 74, 75,
            51, 52, 53, 28, 29, 30, 31, 32, 33, 8,
            9, 10, 11, 35, 36, 37, 38, 39, 63, 64, 
            65, 89, 90, 91, 115, 116, 140, 141, 165, 166, 
            189, 213, 237, 261, 285, 284, 308, 332, 331, 330
        ];

        uint16[118] memory hair3Inner = [
            // starting top left by row
            54, 55, 56, 57, 58, 59, 60, 61, 62, 76,
            77, 78, 79, 80, 81, 82, 83, 84, 85, 86,
            87, 88, 100, 101, 102, 103, 104, 105, 106, 107,
            108, 109, 110, 111, 112, 113, 114, 123, 124, 125, 
            126, 127, 128, 129, 130, 131, 132, 133, 134, 135,
            136, 137, 138, 139, 147, 148, 149, 150, 151, 152,
            153, 154, 155, 156, 157, 158, 159, 160, 161, 162,
            163, 164, 170, 171, 172, 173, 174, 175, 176, 177,
            178, 179, 180, 181, 182, 183, 184, 185, 186, 187,
            188, 195, 196, 200, 201, 202, 204, 205, 206, 207, 
            209, 210, 211, 212, 219, 220, 235, 236, 243, 244,
            259, 260, 267, 268, 283, 291, 292, 316
        ];

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

            if(version == 2){
                for(uint i = 0; i < hair2Outline.length; i++){
                    grid[hair2Outline[i]] = 1;
                }
                for(uint i = 0; i < hair2Inner.length; i++){
                    grid[hair2Inner[i]] = 2;
                }
                for(uint i = 0; i < hair2Cleanup.length; i++){
                    grid[hair2Cleanup[i]] = 0;
                }
            }

            if(version == 3){
                for(uint i = 0; i < hair3Outline.length; i++){
                    grid[hair3Outline[i]] = 1;
                }
                for(uint i = 0; i < hair3Inner.length; i++){
                    uint8 rand = uint8(uint256(keccak256(abi.encodePacked(seed, i)))) % 100;
                    uint16 index = hair3Inner[i];
                    if(index < 128 || (index > 132 && index < 138)){
                        grid[hair3Inner[i]] = 3;
                    } else {
                        grid[hair3Inner[i]] = 2;
                    }   
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

    function getSkin(
        uint16[576] memory grid
    ) public pure returns (uint16[576] memory) {
        for (uint i = 0; i < grid.length; i++) {
            if (i / 24 > 8 && i / 24 < 21) {
                if (i % 24 > 5 && i % 24 < 18) {
                    if (grid[i] == 0) {
                        grid[i] = 6;
                    }
                }
            }
        }
        // custom
        grid[486] = 0;
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

    function uintToString(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        j = _i;
        while (j != 0) {
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        str = string(bstr);
    }
}