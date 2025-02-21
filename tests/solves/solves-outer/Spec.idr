module Spec

import Language.Implicits.IfUnsolved

f : (0 _ : IfUnsolved (List Nat) ty) => ty -> Nat
f _ = 6

g : {x : List ?} -> Nat
g = f x
