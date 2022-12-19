module Spec

data X : Type where
  MkX : {0 n : Nat} -> (m : Nat) -> X

unXm : X -> Nat
unXm $ MkX m = m

Val : Nat
Val = unXm $ MkX 5
