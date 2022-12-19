module Spec

import Language.Implicits.IfUnsolved

data X : Type where
  MkX : {0 n : Nat} -> (0 _ : 15 `IfUnsolved` n) => (m : Nat) -> X

unXm : X -> Nat
unXm $ MkX m = m

Val_m : Nat
Val_m = unXm $ MkX 5

val_m_corr : Val_m === 5
val_m_corr = Refl

0 unXn : X -> Nat
unXn $ MkX {n} _ = n

0 Val_n : Nat
Val_n = unXn $ MkX 5

0 val_n_corr : Val_n === 15
val_n_corr = Refl
