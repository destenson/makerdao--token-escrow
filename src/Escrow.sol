pragma solidity ^0.4.19;

import 'ds-token/token.sol';

contract EscrowFactory {
    mapping(address=>bool) isEscrow;
    function make( bytes32 wut_
                 , address src
                 , address dst
                 , address arb
                 , DSToken gem
                 , uint256 wad
                 )
        returns (Escrow);
}

contract Escrow {
    // HOW
    // 0: Unfunded
    // 1: Funded
    // 2: Deal, src
    // 3: Deal, arb
    // 4: Undo, dst
    // 5: Undo, arb
    uint8   public how; 
    bytes32 public wut;
    address public src;  // Puts gems into escrow
    address public dst;  // Receives gems from escrow
    address public arb;  // arbitrator
    DSToken public gem;  // The token in escrow
    uint256 public wad;  // Amount of gem

    event Update(uint8 indexed how);


    function Escrow( bytes32 wut_
                   , address src_
                   , address dst_
                   , address arb_
                   , DSToken gem_
                   , uint256 wad_
                   )
    {
        wut = wut_;
        src = src_;
        dst = dst_;
        arb = arb_;
        gem = gem_;
        wad = wad_;
        how = 0;
        Update(how);
    }

    function sign() {
        gem.pull(msg.sender, wad);
        how = 1;
        Update(how);
    }
    function deal() {
        if (msg.sender == src) {
            how = 2;
        } else if (msg.sender == arb) {
            how = 3;
        } else {
            revert();
        }
        gem.push(dst, wad);
        Update(how);
    }
    function bail() {
        if (msg.sender == dst) {
            how = 4;   
        } else if (msg.sender == arb) {
            how = 5;
        } else {
            revert();
        }
        gem.push(src, wad);
        Update(how);
    }
}
