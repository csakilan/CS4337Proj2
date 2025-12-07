LOG ENTRY 1 12/06/2025 11:35 PM :

Hello, this is my very first log entry for the find maze project 2. 

I am very excited to do this project and I am going to try to finish a bulk of the work within the next two hours before I go to sleep!


LOG ENTRY 2 12/07/2025 01:08 AM:

I have imported all the helper files and created the base file project2.pl

I have also installed swipl to run terminal commands with the open source SWI prolog CLI


LOG ENTRY 3 12/07/2025 1:46 AM:

Now I have implemeted cell_at/4 to look up a cell in maze by 0 based row and column indices using nth0/3

I tested it on the sample_maze/1, to make sure that 1,1 gives s, and 1,2 gives e  and so on


LOG ENTRY 4 12/07/2025 3:51 PM:

Woke up and now have written a lot more code


first I hadded the find_start to find the coordinates of the start cell

then I also did the hascell to check whether the symbil liek s or e is anyhwere on the maze
I also created the basics of the validation of the maze,that uses maze_dimesions and has-cell/2 to make sure that the maze has at least one row and oclumn

There is also the exactly_one_start ufnction to make sure that there is only once start cell and not many s positions on the map

I also tested everythign to make sur that it all works on the sample_maze

