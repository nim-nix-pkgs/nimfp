{
  description = ''Nim functional programming library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimfp-v0_2_2.flake = false;
  inputs.src-nimfp-v0_2_2.owner = "vegansk";
  inputs.src-nimfp-v0_2_2.ref   = "refs/tags/v0.2.2";
  inputs.src-nimfp-v0_2_2.repo  = "nimfp";
  inputs.src-nimfp-v0_2_2.type  = "github";
  
  inputs."nimboost".dir   = "nimpkgs/n/nimboost";
  inputs."nimboost".owner = "riinr";
  inputs."nimboost".ref   = "flake-pinning";
  inputs."nimboost".repo  = "flake-nimble";
  inputs."nimboost".type  = "github";
  inputs."nimboost".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimboost".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimfp-v0_2_2"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimfp-v0_2_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}