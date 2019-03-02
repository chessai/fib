{ pkgs }:

self: super:

with { inherit (pkgs.stdenv) lib; };

with pkgs.haskell.lib;

{
  fib = (
    with rec {
      fibSource = pkgs.lib.cleanSource ../.;
      fibBasic  = self.callCabal2nix "fib" fibSource { };
    };
    overrideCabal fibBasic (old: {
    })
  );
}
