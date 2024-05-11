# MoString 🔥

This repository explores string concatenation in [Mojo](https://docs.modular.com/mojo) and strategies for performance optimization. We introduced `MoString`, a simple wrapper around the standard Mojo `String` struct that features a custom in-place addition operator (`__iadd__`). It primarily enhances performance by employing a pre-allocation memory strategy, akin to what is used in various `StringBuilder` implementations.

We invite everyone interested to contribute different implementations of efficient string concatenation to this repository. Our aim is to build this repository into a valuable resource that could lead to a proposal for the Mojo standard library. Ideally, this repo will eventually render itself obsolete 🔥.

## Memory Management

This following demo aims to showcase the memory management of `MoString`:

- The capacity (allocated memory) is increased only when necessary.
- When additional memory is needed, the capacity is doubled. This allocation strategy is designed to minimize future memory allocations by providing extra memory space before it's actually required.
- Use the `optimize_memory` method to minimize the allocated memory to what's needed (`capacity=size`).
- Access the underlying String variable through `mostring_var.string` for standard String operations, including the use of `+=`.
- The current size is displayed as `X+1`, where "+1" represents the trailing null terminator each String in Mojo contains.

```python
from mostring import MoString

fn main():
    
    var text = MoString("Alice:")
    print(text.info())

    text+="\nIf I had"
    print(text.info())

    text+=" a world on my own"
    print(text.info())

    text.optimize_memory()
    print(text.info())

    text+=",\neverything"
    print(text.info())

    text+=" would be nonsense."
    print(text.info())

    text.string+="\nNothing would be what it is\nbecause everything would be what it isn't."
    print(text.info())

```

Output with additional comments:

```bash
# Init
Alice:
(Size: 6+1, Capacity: 7)

# Capcacity doubled twice
Alice:
If I had
(Size: 15+1, Capacity: 28)

# Capacity doubled
Alice:
If I had a world on my own
(Size: 33+1, Capacity: 56)

# optimize_memory call, memory/capacity is reduced to size
Alice:
If I had a world on my own
(Size: 33+1, Capacity: 34)

#  Capacity doubled
Alice:
If I had a world on my own,
everything
(Size: 45+1, Capacity: 68)

# Enough capacity available 
Alice:
If I had a world on my own,
everything would be nonsense.
(Size: 64+1, Capacity: 68)

# Direct String operation, capacity = size 
Alice:
If I had a world on my own,
everything would be nonsense.
Nothing would be what it is
because everything would be what it isn't.
(Size: 135+1, Capacity: 136)
```

## Benchmark

To test the concatenation speed of `MoString`, we concatenate the phrase 'White Rabbit' 100k times. We observe a ~4000x speed improvement over the standard String for this task on our machine.

```python
from time import now

from mostring import MoString

fn main():
    alias NUM = 100_000
    alias STR = "White Rabbit"

    var start1 = now()
    var res1=String("")  
    for _ in range(NUM):
        res1+=STR
    var elapsed1=(now()-start1)/1_000_000_000
     
    var start2 = now()
    var res2= MoString()
    for _ in range(NUM):
        res2+=STR
    var elapsed2=(now()-start2)/1_000_000_000

    var result = MoString()
    result+="String based: " + str(elapsed1) + " sec\n"
    result+="MoString based: " + str(elapsed2) + " sec\n"
    result+="SpeedUp: " + str(elapsed1/elapsed2) + " \n"
   
    print(result)
```

Output:

```bash
String based: 17.9689 sec
MoString based: 0.004431 sec
SpeedUp: 4055.269
```

## Contribute Your Implementation

Calling all Mojo wizards, we’re looking for your magic! Contribute your implementation to this repository to help advance the community insights into efficient string concatenation in Mojo. And please don't hestiate to share whatever you come up with, this is not a competion. PRs most welcome 🔥

## License

MIT
