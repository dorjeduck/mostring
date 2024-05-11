from mostring import MoString

fn main():
    
    var text = MoString("Alice:")
    print(text.info())

    text.string+=" If I had"
    print(text.info())

    text+=" a world on my own"
    print(text.info())

    text+=", everything would be nonsense."
    print(text.info())

    text.optimize_memory()
    print(text.info())
   
