pragma solidity ^0.4.19;

import "ds-test/test.sol";

import "./Escrow.sol";

contract EscrowTest is DSTest {
    Escrow escrow;

    function setUp() public {
        escrow = new Escrow();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
