// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.15;

import {LexLocker} from "../LexLocker.sol";

import {MockERC20} from "@solmate/test/utils/mocks/MockERC20.sol";

import "@std/Test.sol";

contract LexLockerTest is Test {
    using stdStorage for StdStorage;

    LexLocker locker;
    
    /// @dev Users

    uint256 immutable alicesPk =
        0x60b919c82f0b4791a5b7c6a7275970ace1748759ebdaa4076d7eeed9dbcff3c3;
    address public immutable alice = 0x503408564C50b43208529faEf9bdf9794c015d52;

    uint256 immutable bobsPk =
        0xf8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315;
    address public immutable bob = 0x001d3F1ef827552Ae1114027BD3ECF1f086bA0F9;

    uint256 immutable charliesPk =
        0xb9dee2522aae4d21136ba441f976950520adf9479a3c0bda0a88ffc81495ded3;
    address public immutable charlie =
        0xccc4A5CeAe4D88Caf822B355C02F9769Fb6fd4fd;

    uint256 immutable nullPk =
        0x8b2ed20f3cc3dd482830910365cfa157e7568b9c3fa53d9edd3febd61086b9be;
    address public immutable nully = 0x0ACDf2aC839B7ff4cd5F16e884B2153E902253f2;

    function setUp() public {
        console.log(unicode"🧪 Testing LexLocker...");
        locker = new LexLocker("gm");
        mockDai = new MockERC20("Dai", "DAI", 18);
        // 1B mockDai!
        mockDai.mint(address(this), 1000000000 * 1e18);
        mockDai.approve(address(locker), type(uint256).max);
        startHoax(alice, alice, type(uint256).max);
        registerResolver(true, 20);
        vm.stopPrank();
    }

    function testDepositETH() public {
        locker.deposit{value: 1 ether}(
            bob,
            charlie,
            address(0),
            [1 ether],
            0,
            false,
            "DEAL"
        );
    }
}
