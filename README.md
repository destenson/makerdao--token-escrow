READ functions:
---

`how`: Contract state:

```
    // 0: Unfunded
    // 1: Funded
    // 2: Deal, src
    // 3: Deal, arb
    // 4: Undo, dst
    // 5: Undo, arb

```

`wut`: Arbitrary user data, for example, hash of agreement text

`src`: Tokens are coming FROM this address

`dst`: Tokens are going TO this address

`arb`: Arbitration address

`gem`: The token being moved

`wad`: How much of the token is to be moved

ACTIONS
---

`sign`: `src` must `sign` the escrow to enable it, which will `pull` `wad` `gem`s from their account into the escrow contract

`deal`: The `src` or `arb` addresses can cause the escrow to `push` the `gem`s to the `dst` address

`bail` The `dst` or `arb` addresses can cause the escrow to `push` the `gem`s back to the `src` address


EVENTS
---

`Update(uint8 indexed how) anonymous`: Logged every time state changes
