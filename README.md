<!-- idris
module README

import Language.Implicits.IfUnsolved
-->

# If your implicit is unsolved

Little helper to have a default value for an implicit which otherwise would be unsolved

## Small artificial example

Consider the following datatype

<!-- idris
namespace Unsolved {
-->

```idris
data X : Nat -> Type where
  MkX : (m : Nat) -> X n
```

As you can see, its constructor has an implicit parameter which can be determined by its return type:

```idris
x2 : X 2
x2 = MkX 16
```

Sometimes a polymorphic value can be swallowed by a polymorphic function, e.g.:

```idris
unXm : X n -> Nat
unXm $ MkX m = m

v : Nat
v = unXm $ MkX 5
```

<!-- TODO to put the code above into a `failing` block as soon as https://github.com/idris-lang/Idris2/issues/2821 is solved -->

In this case, we get an error

```
Error: Unsolved holes:
 07 | unXm : X n -> Nat
 08 | unXm $ MkX m = m
 09 |
 10 | v : Nat
 11 | v = unXm $ MkX 5
          ^^^^^^^^^^^^
```

This error is since neither constructor `MkX`, nor function `unXm` cares about the value of parameter `n`,
but compiler still needs to fill it some value, and cannot figure out any particular value himself.

<!-- idris
  }
-->

## If we really need

Sometimes we really need such expressions work, and we can name a value which compiler could choose for such a case.
However, we don't want to lose an ability for such implicit values to be determined by type of some other context.

For this purpose, this library provides an interface `IfUnsolved`, which makes given implicit the default value
only in the case, when this implicit would be unsolved otherwise:

```idris
data X : Nat -> Type where
  MkX : (0 _ : 42 `IfUnsolved` n) => (m : Nat) -> X n
```

In this case both previous examples would compile.

Here the value of the implicit is determined by type:

```idris
x2 : X 2
x2 = MkX 16
```

But in the case, when nothing explicitly determines the value, it is chosen by `IfUnsolved` and no error happens:

<!-- idris
unXm : X n -> Nat
unXm $ MkX m = m
-->

```idris
v : Nat
v = unXm $ MkX 5
```

## Usage

The `IfUnsolved` interface resides in the `Language.Implicits.IfUnsolved` module.

If you use [`pack`](https://github.com/stefan-hoeck/idris2-pack/) package manager, it is enough to add `if-unsolved-implicit` to `depends` section
of your `.ipkg`-file, or to call `pack install if-unsolved-implicit` to install it directly.
