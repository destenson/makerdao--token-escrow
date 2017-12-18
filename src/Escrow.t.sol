pragma solidity ^0.4.19;

import "ds-test/test.sol";

import "./Escrow.sol";

contract EscrowTest is DSTest {
    Escrow escrow;
    address ali;
    address bob;
    address jud;
    DSToken gem;


    function setUp() public {
        escrow = new Escrow(0, ali, bob, jud, gem, 10 ether);
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
