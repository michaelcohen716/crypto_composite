// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IBioAttributes {
    function getAttributes(
        address owner,
        uint256 bioSeed
    ) external view returns (string memory);
}

contract BioAttributes {
    string[5] sectors = ["DeFi", "NFTs", "Investing", "Media", "L1/L2"];

    function getAttributes(
        address owner,
        uint256 bioSeed
    ) public view returns (string memory) {
        uint256 ownerSeed = uint256(uint160(owner)); // todo: mint seed
        string memory sector = getSector(ownerSeed);
        return
            string(
                abi.encodePacked(
                    '"attributes": [{"trait_type": "project", "value": "',
                    "project xyz", // todo: replace
                    '"}, {"trait_type": "role", "value": "',
                    "frontend dev", // todo: replace
                    '"}, {"trait_type": "vibe", "value": "',
                    "chaotic neutral", // todo: replace
                    '"}, {"trait_type": "sector", "value": "',
                    sector,
                    '" }]'
                )
            );
    }

    function getSector(uint256 ownerSeed) public view returns (string memory) {
        uint256 sectorNum = getSectorNum(ownerSeed);
        return sectors[sectorNum];
    }

    function getSectorNum(uint256 ownerSeed) internal pure returns (uint256) {
        uint256 num = (ownerSeed % 36763) % 100;
        if (num <= 20) {
            return 0;
        } else if (num <= 40) {
            return 1;
        } else if (num <= 60) {
            return 2;
        } else if (num <= 80) {
            return 3;
        } else {
            return 4;
        }
    }

    function getProjectRole(
        uint256 ownerSeed
    ) public pure returns (string memory role) {
        uint256 sectorNum = getSectorNum(ownerSeed);

        if (sectorNum == 0) {
            string[8] memory roles = [
                "Founder",
                "Backend Developer",
                "Frontend Developer",
                "Fullstack Developer",
                "Community Manager",
                "Growth Lead",
                "Partnerships",
                "Governance Lead"
            ];
            uint256 num = (ownerSeed % 6657) % roles.length;
            role = roles[num];
        } else if (sectorNum == 1) {
            string[8] memory roles = [
                "Founder",
                "Developer",
                "Creator",
                "Curator",
                "Investor",
                "Program Manager",
                "Trader",
                "Partnerships"
            ];
            uint256 num = (ownerSeed % 6657) % roles.length;
            role = roles[num];
        } else if (sectorNum == 2) {
            string[8] memory roles = [
                "Partner",
                "Deal Partner",
                "Deal Associate",
                "Platform",
                "Closer",
                "Deal Analyst",
                "Deal Researcher",
                "Deal Operations"
            ];
            uint256 num = (ownerSeed % 6657) % roles.length;
            role = roles[num];
        } else if (sectorNum == 3) {
            string[8] memory roles = [
                "Podcast Host",
                "Podcast Producer",
                "Researcher",
                "Social Media Manager",
                "Reporter",
                "Subject Matter Expert",
                "Sales Manager",
                "Onchain Sleuth"
            ];
            uint256 num = (ownerSeed % 6657) % roles.length;
            role = roles[num];
        } else {
            // sectorNum 4
            string[9] memory roles = [
                "Cofounder",
                "Infra Developer",
                "DeFi Lead",
                "NFT Lead",
                "Community Manager",
                "Researcher",
                "Treasury Manager",
                "Grants Lead",
                "Governance Lead"
            ];
            uint256 num = (ownerSeed % 6657) % roles.length;
            role = roles[num];
        }
    }

    function getProjectName(
        uint256 ownerSeed
    ) public pure returns (string memory name) {
        uint256 sectorNum = getSectorNum(ownerSeed);

        if (sectorNum == 0) {
            // DeFi
            string[14] memory firstWords = [
                "Liquid",
                "Meta",
                "Doge",
                "Synth",
                "Impact",
                "Linear",
                "Uni",
                "Pepe",
                "Tribal",
                "Magic",
                "Insta",
                "Quick",
                "AI",
                "Inverse"
            ];
            string[14] memory secondWords = [
                "Lend",
                "Stable",
                "DEX",
                "Perp",
                "Rocket",
                "Dingo",
                "Token",
                "Inu",
                "Peepo",
                "Money",
                "Meme",
                "GPT",
                "Dino",
                "Turbo"
            ];
            string[10] memory thirdWords = [
                "DAO",
                "Network",
                "Swap",
                "Pool",
                "Exchange",
                "Marketplace",
                "Protocol",
                "Finance",
                "Cartel",
                "Strategies"
            ];
            uint256 num1 = (ownerSeed % 9879) % firstWords.length;
            uint256 num2 = (ownerSeed % 3214) % secondWords.length;
            uint256 num3 = (ownerSeed % 2047) % thirdWords.length;
            name = string(
                abi.encodePacked(
                    firstWords[num1],
                    " ",
                    secondWords[num2],
                    " ",
                    thirdWords[num3]
                )
            );
        } else if (sectorNum == 1) {
            // nfts
            string[10] memory firstWords = [
                "Grail",
                "Monkey",
                "Super",
                "Galactic",
                "Cyber",
                "Ethereal",
                "Phantom",
                "Floor",
                "Digital",
                "Creator"
            ];
            string[10] memory secondWords = [
                "Museum",
                "Art House",
                "Land",
                "Cats",
                "Studio",
                "Canvas",
                "Pixel",
                "Ocean",
                "Pump",
                "Trading"
            ];
            string[13] memory thirdWords = [
                "Visions",
                "Fund",
                "Market",
                "Platform",
                "Universe",
                "Gallery",
                "Gotchi",
                "Blocks",
                "DAO",
                "Drops",
                "Art",
                "Bazaar",
                "Analytics"
            ];
            uint256 num1 = (ownerSeed % 9879) % firstWords.length;
            uint256 num2 = (ownerSeed % 3214) % secondWords.length;
            uint256 num3 = (ownerSeed % 2047) % thirdWords.length;
            name = string(
                abi.encodePacked(
                    firstWords[num1],
                    " ",
                    secondWords[num2],
                    " ",
                    thirdWords[num3]
                )
            );
        } else if (sectorNum == 2) {
            // investing
            string[10] memory firstWords = [
                "Skeuomorphic",
                "Fully Diluted",
                "Disruptive",
                "Scalable",
                "Intriguing",
                "Competitive",
                "Unique",
                "Teamwork",
                "Stakeholder",
                "Alpha"
            ];
            string[11] memory secondWords = [
                "Value Add",
                "Runway Burn",
                "CAC",
                "Due Diligence",
                "Value Prop",
                "Low Float",
                "Traction",
                "Narrative",
                "Exit Strategy",
                "Issuance",
                "Table Stakes"
            ];
            string[8] memory thirdWords = [
                "Fund",
                "VC",
                "Management",
                "Ventures",
                "Partners",
                "Capital",
                "Investors",
                "Ltd."
            ];
            uint256 num1 = (ownerSeed % 9879) % firstWords.length;
            uint256 num2 = (ownerSeed % 3214) % secondWords.length;
            uint256 num3 = (ownerSeed % 2047) % thirdWords.length;
            name = string(
                abi.encodePacked(
                    firstWords[num1],
                    " ",
                    secondWords[num2],
                    " ",
                    thirdWords[num3]
                )
            );
        } else if (sectorNum == 3) {
            // media
            string[10] memory firstWords = [
                "Decentralized",
                "Quantum",
                "Crypto",
                "DeFi",
                "NFT",
                "Distributed",
                "Pioneer",
                "Onchain",
                "Tokenized",
                "Digital"
            ];
            string[11] memory secondWords = [
                "Blockchain",
                "Asset",
                "Vanguard",
                "Liquidity",
                "Syndicate",
                "Whale",
                "Alpha",
                "Communications",
                "Streaming",
                "Studio",
                "Publishing"
            ];
            string[8] memory thirdWords = [
                "Broadcast",
                "Group",
                "Media",
                "Media Desk",
                "Network",
                "Bureau",
                "Publications",
                "Outlet"
            ];
            uint256 num1 = (ownerSeed % 9879) % firstWords.length;
            uint256 num2 = (ownerSeed % 3214) % secondWords.length;
            uint256 num3 = (ownerSeed % 2047) % thirdWords.length;
            name = string(
                abi.encodePacked(
                    firstWords[num1],
                    " ",
                    secondWords[num2],
                    " ",
                    thirdWords[num3]
                )
            );
        } else {
            // L1/L2
            string[13] memory firstWords = [
                "Wavy",
                "ZK",
                "Optimistic",
                "Smart",
                "Catalyst",
                "Bear",
                "Bull",
                "Solar",
                "Sigma",
                "Trustless",
                "InterBlockchain",
                "Alpha",
                "Low Fee"
            ];
            string[11] memory secondWords = [
                "Token",
                "Rollup",
                "Nexus",
                "Blockchain",
                "Protocol",
                "Node",
                "Oasis",
                "Sphere",
                "Quantum",
                "Nucleus",
                "Link"
            ];
            string[7] memory thirdWords = [
                "Chain",
                "Network",
                "EVM",
                "Ledger",
                "Commons",
                "Blockchain",
                "DAO"
            ];
            uint256 num1 = (ownerSeed % 9879) % firstWords.length;
            uint256 num2 = (ownerSeed % 3214) % secondWords.length;
            uint256 num3 = (ownerSeed % 2047) % thirdWords.length;
            name = string(
                abi.encodePacked(
                    firstWords[num1],
                    " ",
                    secondWords[num2],
                    " ",
                    thirdWords[num3]
                )
            );
        }
    }
}
