[![wakatime](https://wakatime.com/badge/user/75e033f5-beb6-4359-afae-db8209348d42/project/93ce6a5f-bded-4337-881b-e97b22aa402e.svg)](https://wakatime.com/badge/user/75e033f5-beb6-4359-afae-db8209348d42/project/93ce6a5f-bded-4337-881b-e97b22aa402e)

# SHA256

SHA256 is a hashing algorithm that is very commonly used today. As I wanted to understand how this important algorithm worked, I decided to build my own implementation of it. I used a [python tutorial](https://medium.com/@domspaulo/python-implementation-of-sha-256-from-scratch-924f660c5d57) to guide me along; however, I rewrote a lot of the more basic functions. As far as I can tell, this algorithm is correct (returning what it should), which I find impressive considering how this works. 

## Running Code

In order to run this code, simply download the files, enter the direction with the code, and run: ``` julia main.jl "STUFF YOU WANT TO HASH" ```. This should, after a delay, return the hash of whatever you inputted. Of course, this requires you to have installed Julia. This can be easily done from [here](https://julialang.org/downloads/). 

## What is hashing? 

Hashing is the process of taking data and turning it into a set-length, scrambled "hash" which is non-reversible. This means that no matter if you hash "hi" or the communist manifesto, it will turn out to be the same length (a 64 character hex digest in the case of SHA256). It is also important to note that hashing "hi" will always return the same thing, for SHA256 that would be: "8f434346648f6b96df89dda91c5176b10a6d83961dd3c1ac88b59b2dc327aa4"

These algorithms are super useful in securing a wide variety of systems. For starters, passwords are commonly hashed in storage. This means instead of storing the user's password, the hash will be stored, something that can't be reversed back to the password (ideally). Therefore, if someone were to steal the file that contains all these hashes, they wouldn't be able to get the passwords without brute force as they can't reverse any of the hashes. 

Another very useful application of hash algorithms is in blockchains. It is much easier to store the 64 character digest than the massive block in a blockchain and they both make sure that the block can't be altered. Notice that if you hash: 

``` "hi" --> "8f434346648f6b96df89dda91c5176b10a6d83961dd3c1ac88b59b2dc327aa4" ```

``` "hi  " --> "df103b54b5632163114d83b7d24b3f092c5a8eda7e2b79958bf7eb93d14c338a" ```

By simply adding a space to the end of the hash, the output completely changes. So **any** information changed in a block could be noticable by simply looking at the hash. This also means that hashes can be useful in any circumstance where you need to confirm the correctness of data. For example, let's say when you sent a message to someone, you hashed the message with some code each of you had and included it at the end of the message. The receiver will do the same and if the hashes don't match, then information in the message must have been changed. 

## Next Steps

I think that I learned a lot from building this algorithm as it really helped me understand how the whole thing worked. I had done minor research into SHA2 before, but gave up pretty quickly because it seemed overly complicated. While some of the calculations don't make a ton of sense to me still, I have a feeling this is intentional because it is supposed to make it a random mess, that is what hashing does, so I am not going to try to fully understand the reasoning behind everything. A cool benefit of this project was that I also got much, much more familiar with some cool functions in Julia that allow you to do much more in much less space. I was able to compact many functions (from their state in the tutorial) and use some interesting functions to accomplish it. 

For starters, I ended up using a really weird system for storing binary numbers for this algorithm. This was partially because of the tutorial I followed, but also I accidentally just used strings instead of integers and then kept using them despite them not being the best option. Working on odd issues like this would probably be something good to do in the future. This project was chosen over implementing some kind of symmetric key encryption. I decided to implement a hashing algorithm instead as I had just implemented [RSA](https://github.com/TheSharkhead2/RSA), but working through symmetric key encryption would be fun in the future. I also think working through some other hashing algorithms would be interesting just to get a better grasp on what approaches we take to hashing. Even implementing something like MD5 would be cool. Finally, I also may want to take another crack at understanding the logic behind the calculations in this algorithm, though this may need to come after I work through some other hashing algorithms. 