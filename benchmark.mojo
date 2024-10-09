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
   
    print(result.string)

