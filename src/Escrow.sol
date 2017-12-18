pragma solidity ^0.4.19;

import 'ds-token/token.sol';

contract EscrowFactory {
    mapping(address=>bool) isEscrow;
    event NewEscrow( address indexed src
                   , address indexed dst
                   , address indexed arb
                   , DSToken indexed gem
                   , Escrow          out
                   ) anonymous;
    function make( bytes32 wut
                 , address src
                 , address dst
                 , address arb
                 , DSToken gem
                 , uint256 wad
                 )
        returns (Escrow)
    {
        var e = new Escrow(wut, src, dst, arb, gem, wad);
        isEscrow[e] = true;
        NewEscrow(src, dst, arb, gem, e);
        return e;
    }
}

contract Escrow {
    // HOW
    // 0: Unfunded
    // 1: Funded
    // 2: Deal, src
    // 3: Deal, arb
    // 4: Undo, dst
    // 5: Undo, arb
    uint8   public how;  // state
    bytes32 public wut;  // contract memo
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

    function sign()
    {
        require(how == 0);
        require(msg.sender == src)
        gem.pull(msg.sender, wad);
        how = 1;
        Update(how);
    }
    function deal() {
        require(how == 1);
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
        require(how == 1);
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
