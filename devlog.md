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



LOG ENTRY 5 AND FINAL LOGG ENTRY!!!!!! 12/08/2025 10:42 AM:

I have been working on this consistently over the past day and have essentially completed the requirements. But I think I will probably add some extra stuff before the submission date.

I have added a lot more hecks: check if mazee is rectangular, to make sure that w,f,s,e are the only symbols, and to confirm that every cell is valid

There is also movement logic, and the follow actions function executes athe whole list of actions from a starting position, and the legal step calls recursively and it fails as soon as any step is deemed invald.

I am also using DFS to search and have the search_path/5 function to explore the maze.

I also canged teh find_exist method to have both verification and generation so that in generation, it validates the mzze, fidns the start, and calls search path and again checks the end position.


This is the essence of what I have added, everythign should work now, but I will be checking further and working on this later after looking through all the requirements.