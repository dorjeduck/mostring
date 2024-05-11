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

    text.string+="Nothing would be what it is because everything would be what it isn't."
    print(text.info())