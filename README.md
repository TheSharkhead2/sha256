[![wakatime](https://wakatime.com/badge/user/75e033f5-beb6-4359-afae-db8209348d42/project/93ce6a5f-bded-4337-881b-e97b22aa402e.svg)](https://wakatime.com/badge/user/75e033f5-beb6-4359-afae-db8209348d42/project/93ce6a5f-bded-4337-881b-e97b22aa402e)

# SHA256

SHA256 is a hashing algorithm that is very commonly used today. As I wanted to understand how this important algorithm worked, I decided to build my own implementation of it. I used a [python tutorial](https://medium.com/@domspaulo/python-implementation-of-sha-256-from-scratch-924f660c5d57) to guide me along; however, I rewrote a lot of the more basic functions. As far as I can tell, this algorithm is correct (returning what it should), which I find impressive considering how this works. 

## Running Code

In order to run this code, simply download the files, enter the direction with the code, and run: ``` julia main.jl "STUFF YOU WANT TO HASH" ```. This should, after a delay, return the hash of whatever you inputted. Of course, this requires you to have installed Julia. This can be easily done from [here](https://julialang.org/downloads/). 

## Next Steps

I think that I learned a lot from building this algorithm as it really helped me understand how the whole thing worked. I had done minor research into SHA2 before, but gave up pretty quickly because it seemed overly complicated. While some of the calculations don't make a ton of sense to me still, I have a feeling this is intentional because it is supposed to make it a random mess, that is what hashing does, so I am not going to try to fully understand the reasoning behind everything. A cool benefit of this project was that I also got much, much more familiar with some cool functions in Julia that allow you to do much more in much less space. I was able to compact many functions (from their state in the tutorial) and use some interesting functions to accomplish it. 

This project was chosen over implementing some kind of symmetric key encryption. I decided to implement a hashing algorithm instead as I had just implemented [RSA](https://github.com/TheSharkhead2/RSA), but working through symmetric key encryption would be fun in the future. I also think working through some other hashing algorithms would be interesting just to get a better grasp on what approaches we take to hashing. Even implementing something like MD5 would be cool. Finally, I also may want to take another crack at understanding the logic behind the calculations in this algorithm, though this may need to come after I work through some other hashing algorithms. 