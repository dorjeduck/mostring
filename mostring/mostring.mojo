from memory import memcpy

struct MoString[MEM_AHEAD_FACTOR:Float32 = 2](CollectionElement,Stringable):
    
    var string:String
    fn __init__(inout self,string:StringRef="",*,capacity:Int = 1):
        constrained[MEM_AHEAD_FACTOR>=1.25]()
        """Construct a MoString from a String object.
        Parameters:
            MEM_AHEAD_FACTOR: The factor by which the allocated memory is increased if needed.
        Args:
            string: The input String.
            capacity: The requested initial memory capacity.
        """

        self.string=string
        if capacity>1 and capacity>self.string._buffer.capacity:
            self.string._buffer._realloc(capacity)

    @always_inline
    fn __iadd__(inout self, other: String):  
        var self_len = len(self.string)
        var other_len = len(other)    
        var total_len = self_len + other_len
        
        # realloc if needed (instead of resize)
        var cap = self.string._buffer.capacity 
        var realloc = False
        
        while cap < total_len+ 1 :
            cap = int(MEM_AHEAD_FACTOR*cap)
            realloc = True
        if realloc:
            self.string._buffer._realloc(cap)

        # Copy the data alongside the terminator.
        memcpy(self.string.unsafe_ptr() + self_len, other.unsafe_ptr(), other_len + 1)

        #Adjust the size
        self.string._buffer.size = total_len+1
    
    fn optimize_memory(inout self):
        if self.string._buffer.size < self.string._buffer.capacity:
            self.string._buffer._realloc(self.string._buffer.size)

    fn info(self,include_string:Bool=True) -> String:
        var res:String = ""
        if include_string:
            res +=  self.string + "\n"
        res += "(Size: " + str(self.string._buffer.size-1) + '+1'  + ", Capacity: " + str(self.string._buffer.capacity) + ")"
        if include_string:
            res+="\n"
        return res

    @always_inline
    fn __str__(self) -> String:
        return self.string

    @always_inline
    fn __copyinit__(inout self, existing: Self):
        """Creates a deep copy of an existing MoString.

        Args:
            existing: The MoString to copy.
        """
        self.string.__copyinit__(existing.string)
    @always_inline
    fn __moveinit__(inout self, owned existing: Self):
        """Move the value of a MoString.

        Args:
            existing: The MoString to move.
        """
        self.string.__moveinit__(existing.string)


