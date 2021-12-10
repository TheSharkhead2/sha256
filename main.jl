"""
For this project I followed this python guide for sha256: 
https://medium.com/@domspaulo/python-implementation-of-sha-256-from-scratch-924f660c5d57


"""

#define initial hash values. Apparently these are fixed 
h = ["6a09e667", "bb67ae85", "3c6ef372", "a54ff53a", "510e527f", "9b05688c", "1f83d9ab", "5be0cd19"]

#again, hardcoded "round constants"
k = ["428a2f98", "71374491", "b5c0fbcf", "e9b5dba5", "3956c25b", "59f111f1", "923f82a4","ab1c5ed5", "d807aa98", "12835b01", "243185be", "550c7dc3", "72be5d74", "80deb1fe","9bdc06a7", "c19bf174", "e49b69c1", "efbe4786", "0fc19dc6", "240ca1cc", "2de92c6f","4a7484aa", "5cb0a9dc", "76f988da", "983e5152", "a831c66d", "b00327c8", "bf597fc7","c6e00bf3", "d5a79147", "06ca6351", "14292967", "27b70a85", "2e1b2138", "4d2c6dfc","53380d13", "650a7354", "766a0abb", "81c2c92e", "92722c85", "a2bfe8a1", "a81a664b","c24b8b70", "c76c51a3", "d192e819", "d6990624", "f40e3585", "106aa070", "19a4c116","1e376c08", "2748774c", "34b0bcb5", "391c0cb3", "4ed8aa4a", "5b9cca4f", "682e6ff3","748f82ee", "78a5636f", "84c87814", "8cc70208", "90befffa", "a4506ceb", "bef9a3f7","c67178f2"]

function sha256(text)
    """


    """

    #use global values for initial hash values/round constants
    global h
    global k

    chunks = process_text(text)

    h = initialize_constants(h)
    k = initialize_constants(k)

    for chunk in chunks #loop through all chunks
        w = split_list(chunk, 32) #split list into lists of length 32

        for i in 1:48 #loop 48 times
            push!(w, fill("0", 32)) #append 48 more 32 bit chunks to list 
        end
        
        for i in 17:64 #loop through values from 17 to 64. This will be the inidices of w which corispond to all 0 lists
            #do math I don't entirely understand
            s0 = xorxor.(circshift(w[i-15], 7), circshift(w[i-15], 18), shr(w[i-15], 3))
            s1 = xorxor.(circshift(w[i-2], 17), circshift(w[i-2], 19), shr(w[i-2], 10))

            w[i] = add(add(add(w[i-16], s0), w[i-7]), s1)
        end
    
    end


end

function text_to_bin(text)
    """
    Convert text to list binary representation 

    """

    #split text into list of 0s and 1s representing binary representation of text (this took some tinkering to find. Basically, get bytes of string, convert bytes to binary, split binary into list (this creates an array of lists), concatinate all lists into one)
    vcat(split.(bitstring.(codeunits(text)),"")...)

end

function process_text(text)
    """
    Process input hash text before hashing 

    """

    bits = text_to_bin(text) #get list of bits representing text (binary conversion)

    len = length(bits) #get length of bit list

    message_len = string.(digits(len, base=2,pad=16) |> reverse) #get bit list representation of message length (solution found here: https://discourse.julialang.org/t/convert-integer-to-bits-array/26663)

    #split into 3 cases: <448, =448, >448
    if len < 448 #if length of bits is less that 448

        push!(bits, "1") #add a single 1 to bits list

        bits = extend_to_length(bits, 448; side="r") #extend bit list to length 448 (append zeros to right)

        bits = append!(bits, message_len) #append message length (in bits) from earlier to bits list such that this is of length 512

        return [bits] #return list 
    
    elseif len == 448 #if length of bits is equal to 448

        push!(bits, "1") #add single 1 to bits list

        bits = extend_to_length(bits, 960; side="r") #extend bit list to length 960 (960+64 = 1024)

        bits = append!(bits, message_len) #append 64 bit long length to make new bits list length 1024 

        return split_list(bits, 512) #return list of bit lists that are length 512 
    
    else #else if the length of bits is over 448

        push!(bits, "1") #add single 1 to bits list

        multiple = len + (512 - (len % 512)) #calculate the next multiple of 512 (higher than currentl length)

        bits = extend_to_length(bits, multiple-64; side="r") #extend bits list to next multiple of 512 (in length) minus 64 (such that I can later append length bit list)

        bits = append!(bits, message_len) #appened message bits list to end of bits list
    end

    return split_list(bits, 512) #return new list of 512 chunks of bits

end

function initialize_constants(constants)
    """
    Takes list of initial hash constants in hexidecimal and coverts to 
    list representing binary 

    """

    out = [] #empty list to append output to 

    for constant in constants #loop through all constants
        push!(out, split(string(parse(Int, constant; base=16); base=2),"")) #convert hexidecimal constant to binary list and then append to output list

    end

    out

end

function bin2hex(value)
    """
    Takes list representing binary and converts to hex

    Parameters
    ----------

    value : list
        List of bits representing binary 

    Returns
    -------

    hex : string
        Hex value of binary

    """

    string(parse(Int, join(value); base=2); base=16) #first join the list into a string, parse it into an integer (from binary), then convert into hexidecimal string

end

function extend_to_length(value, length; side="r")
    """
    Pads binary list on right or left with zeros to set length 

    Parameters
    ----------

    value : list
        Binary number to extend
    
    length : int
        Length to extend to 
    
    side : string, optional
        Default r. If r, right padding, if l, left padding

    Returns
    -------

    out : list
        Extended binary number
    
    """

    if side == "r"
        split(rpad(join(value), length, "0"), "") #join list into string, extend through right padding, convert back to list
    elseif side == "l"
        split(lpad(join(value), length, "0"), "") #join list into string, extend through left padding, convert back to list
    end

end

function split_list(value, length)
    """
    Splits list into smaller lists of desired length. 

    Parameters
    ----------

    value : list
        Binary number in list format 

    length : int
        Desired length for smaller lists

    Returns
    -------

    out : list
        List of multiple smaller lists

    """

    #I found this here: https://docs.julialang.org/en/v1/base/iterators/#Base.Iterators.partition
    collect(Iterators.partition(value, length))

end

### utility functions ###

isTrue(x) = return x == "1" #if 1 return true, else return false

function if_(x, y, z)
    """
    If x is 1, return the y value. Otherwise, return the z value

    """

    if isTrue(x)
        return y
    else
        return z
    end

end

and_(x, y) = return if_(x, y, "0") #if x and y are 1, return 1, else return 0

not_(x) = return if_(x, "0", "1") #if x == 1, return 0. Else return 1. Opposite of input 

xor_(x,y) = string( xor( parse(Int, x), parse(Int, y) ) ) #define xor to work on strings

xorxor(x,y,z) = string(xor(parse(Int, x), xor(parse(Int, y), parse(Int, z)))) #return 1 if odd number of 1s, else 0. (Takes in strings and returns strings, has to convert to int for xor)

shr(x, n) = append!(fill("0", n), x)[1:length(t)] #shift values to right

function maj(x,y,z)
    """
    Return 1 if 1 is majority, return 0 if 0 is majority. 
    Assumes all entries are either 1 or 0.

    """

    if sum(parse.(Int,[x,y,z])) > 1
        return "1"
    else
        return "0"
    end
end

function add(x, y)
    """
    Add two binary numbers together (input as lists). Need to keep same length

    """

    maxLength = max(length(x), length(y)) #get make length of two to keep output at same length

    binarySum = parse(BigInt, join(x); base=2 ) + parse(BigInt, join(y); base=2) #convert the two to integers and add them 

    sumBitstring = bitstring(binarySum) #get bitstring of sum

    diffLength = maxLength - length(sumBitstring) #get difference between maximum length of output and current length of output 

    if diffLength > 0 #if this difference is less than 0, indicating it is over max length 
        sumBitstring = sumBitstring[1+(-diffLength):length(sumBitstring)] #shorten bitstring to correct length
    elseif diffLength < 0 #if this difference is above 0, then something is wrong probably because it has shrunk. So increase size to correct length
        lpad(sumBitstring, maxLength, "0") #extend to correct length
    end

    split(sumBitstring, "") #convert to list and return

end

sha256("test")