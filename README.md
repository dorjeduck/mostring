# MoString 🔥

This repository explores string concatenation in [Mojo](https://docs.modular.com/mojo) and strategies for performance optimization. We introduce `MoString`, a simple wrapper around the standard Mojo `String` struct that features a custom in-place addition operator (`__iadd__`). It primarily enhances performance by employing a pre-allocation memory strategy, akin to what is used in various `StringBuilder` implementations.

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

### MEM_AHEAD_FACTOR parameter for MoString

We introduce a new optional parameter for the `MoString` struct: `MEM_AHEAD_FACTOR`. This parameter allows you to specify the factor by which memory should be increased when additional memory is needed. The default value is 2, and it must be a number greater than or equal to 1.25 . In the following benchmark we compare `MoString` and `MoSting[MEM_AHEAD_FACTOR=16]` with the standard `String` implementation. 

## Benchmark

To test the concatenation speed of `MoString`, we concatenate the phrase 'White Rabbit' 100k times. We observe a ~4000x speed improvement over the standard String for this task on our machine.

```python
from time import now

from mostring import MoString

fn main():
    alias NUM = 100_000
    alias STR = "White Rabbit"

    var start = now()
    var res1=String("")  
    for _ in range(NUM):
        res1+=STR
    var elapsed1=(now()-start)/1_000_000_000
     
    start = now()
    var res2= MoString()
    for _ in range(NUM):
        res2+=STR
    res2.optimize_memory()
    var elapsed2=(now()-start)/1_000_000_000

    start = now()
    var res3= MoString[16]()
    for _ in range(NUM):
        res3+=STR
    res3.optimize_memory()
    var elapsed3=(now()-start)/1_000_000_000

    var result = MoString()
    result+="String based: " + str(elapsed1) + " sec\n"
    result+="\nMoString based: " + str(elapsed2) + " sec\n"
    result+="SpeedUp: " + str(elapsed1/elapsed2) + " \n"
    result+="\nMoString[16] based: " + str(elapsed3) + " sec\n"
    result+="SpeedUp: " + str(elapsed1/elapsed3) + " \n"
   
    print(result)
```

Output:

```bash
String based: 26.020166 sec

MoString based: 0.0069680000000000002 sec
SpeedUp: 3734.2373708381169 

MoString[16] based: 0.0064400000000000004 sec
SpeedUp: 4040.3984472049688 
```

## Contribute Your Implementation

Calling all Mojo wizards, we’re looking for your magic! Contribute your implementation to this repository to help advance the community insights into efficient string concatenation in Mojo. And please don't hestiate to share whatever you come up with, this is not a competion. PRs most welcome 🔥

## License

MIT
