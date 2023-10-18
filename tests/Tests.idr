module Tests

import Test.Golden.RunnerHelper

main : IO ()
main = goldenRunner
  [ "Implicit solves when unsolved" `atDir` "solves"
  , "Documentation"                 `atDir` "docs"
  ]
