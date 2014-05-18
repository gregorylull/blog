#!/bin/bash
# the for-loop operation at the end of this file only changes files with a .js extension
#   one sub-directory deep. i.e. ONLY file.js should have one line appended, 
#   while 'sub_file.js', 'file.txt', and '.hidden' will not be affected

# creates a root testDir in the folder that you run this code, and the following subdirectories

#                      |-- file.js
#           |-- dir1 --|-- file.txt
#           |          |-- .hidden
#           |          |-- dir1_subdir1 -- sub1_file.js  // should not change
#           |          
#           |          |-- file.js
# testDir --|-- dir2 --|-- file.txt
#           |          |-- .hidden
#           |          |-- dir2_subdir1 -- sub2_file.js  // should not change
#           |          
#           |          |-- file.js
#           |-- dir3 --|-- file.txt
#                      |-- .hidden
#                      |-- dir3_subdir1 -- sub3_file.js  // should not change

# create the structure above
# root test directory
mkdir testDir

# test one level deep directory
mkdir testDir/dir1
mkdir testDir/dir2
mkdir testDir/dir3

# test 2 level deep directories for recursive action
mkdir testDir/dir1/dir1_subdir1
mkdir testDir/dir2/dir2_subdir1
mkdir testDir/dir3/dir3_subdir1

# simulate javascript files
touch testDir/dir1/file.js
touch testDir/dir2/file.js
touch testDir/dir3/file.js

# simulate txt files
touch testDir/dir1/file.txt
touch testDir/dir2/file.txt
touch testDir/dir3/file.txt

# simulate hidden files
touch testDir/dir1/.hidden
touch testDir/dir2/.hidden
touch testDir/dir3/.hidden

# simulate two-level deep recursive action
touch testDir/dir1/dir1_subdir1/sub1_file.js
touch testDir/dir2/dir2_subdir1/sub2_file.js
touch testDir/dir3/dir3_subdir1/sub3_file.js

# adding lines to files to show how comment lines will be appended
echo 'within dir1' >> testDir/dir1/file.js
echo 'within dir2' >> testDir/dir2/file.js
echo 'within dir3' >> testDir/dir3/file.js

# append text on the immediate sub-directories of the root using a for-loop
for file in ./testDir/*/*.js
do
  echo "// comment" >> "$file"
done
