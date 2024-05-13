from time import now

from mostring import MoString,MoList

fn main():
    alias NUM = 100000

    alias EXTEND = List(1,2,5,7,5,7,1,3)
    
    var start = now()
    var res1=List[Int]()
    for _ in range(NUM):
        res1.extend(EXTEND)
    var elapsed1=(now()-start)/1_000_000_000
     
    start = now()
    var res2= List[Int]()
    for _ in range(NUM):
        for j in List(1,2,5,7,5,7,1,3,3,4,5,6,6):
            res2.append(j[])

    var elapsed2=(now()-start)/1_000_000_000

    start = now()
    var res3= MoList[Int]()
    for _ in range(NUM):
        res3.extend(EXTEND)
    var elapsed3=(now()-start)/1_000_000_000


    var result = MoString()
    result+="List extend: " + str(elapsed1) + " sec\n"
    result+="\nList append: " + str(elapsed2) + " sec\n"
    result+="SpeedUp: " + str(elapsed1/elapsed2) + " \n"
    result+="\nMoList extend: " + str(elapsed3) + " sec\n"
    result+="SpeedUp to List extend: " + str(elapsed1/elapsed3) + " \n"
    result+="SpeedUp to List append: " + str(elapsed2/elapsed3) + " \n"
   
    print(result)

