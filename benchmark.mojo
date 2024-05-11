from time import now

from mostring import MoString

fn main():
    alias NUM = 100_000
    alias STR = "White Rabbit"

    var start1 = now()
    var res1=String("")  
    for i in range(NUM):
        res1+=STR
    var elapsed1=(now()-start1)/1_000_000_000
     
    var start2 = now()
    var res2= MoString()
    for i in range(NUM):
        res2+=STR
    var elapsed2=(now()-start2)/1_000_000_000

    var result = MoString()
    result+="String based: " + str(elapsed1) + " sec\n"
    result+="MoString based: " + str(elapsed2) + " sec\n"
    result+="SpeedUp: " + str(elapsed1/elapsed2) + " \n"
   
    print(result)