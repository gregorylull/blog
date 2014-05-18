// bash for loop toy problem automate 2014-05-17.md

[john goodman] am i the only one here who wants to resubmit all my toy problems and check what to work on?

TL;DR Goal - learn how to append lines of code/text to specific files within different sub-directories using bash commands/constructs (4 lines!!!)

TL;DR Solution - run this inside any root directory with immediate sub-directories that contain .js files you want to append to:
  for file in ./*/*.js
  do
    echo "// comment\n" >> "$file"
  done

Try before you buy: in case you are not comfortable running the above code, download this test script to any folder, take a look, then enter the following commands in the console:
  # this will give you permission to execute it
  chmod 755 buildDir.sh
  # this executes the script, which creates a root test directory with files and
  # subdirectories, and runs the above for-loop on that test directory
  ./buildDir.sh

That should get you started, read 5 mins more if you would like to increase your bash stats!

My backstory, aka my confession:
Two nights ago I did a very anti-programmer thing. I had a git respository with 40 sub directories that contained files that I wanted to re-submit to an automated solution checker. The specific problem was that this solution checker would only run files that had been changed since the last submission, so I opened each file, looked around to remind myself what the file contained, and added a comment.

I didn't even realize it at the time, but the end result was that I basically manaually added a comment to 40 files in 40 different directories. 

Shame, guilt, and reflection ensued : It was time for me to learn how to wield the Bash hammer.

Shake n Bake:
There are a lot of great guides out there for learning Bash, a Unix shell*, so I will cover only what we need for the for-loop provided above (...and some fun stuff of course)

For-loop structure: 
# The bash for-loop iterates over space-separated items
for i in "one" "two" "three"
do
  echo "$i"
done
# outputs:
one
two
three

1. A <return> effectively separates commands and acts as a semi-colon. 
2. semi-colons are unnecessary unless you run commands on a single line, e.g.: for i in "one two three"; do echo "$i"; done;
3. `echo` automatically adds a newline

Variable declaration, assignment, and expansion:
*note* don't worry about 'polluting' the environment, as soon as you close your terminal window, which is closing an instance of the bash shell, your declared variables will be gone, so have at it!! 
Also, uppercase is generally reserved for global/environment variables, so just play around with lowercase.

Declaration and Assignment
# variables are case-sensitive and assignments must have no spaces in between them, otherwise it is interpreted as a command being passed arguments
name=greg      # works!
name = greg    # -bash errors - name: command not found

Variable value retrieval and expansion
# to retrieve the value of the variable, prefix with a bang $
name=greg
echo $name    # outputs: greg
echo name     # outputs: name

# variables are expanded within double quotes
echo "hi $name"  # outputs: hi greg
echo 'hi $name'  # outputs: hi $name

*note* I use echo for my examples because it is easier to understand and it automatically adds a newline after the output. However, use printf if you want to have more control over the formatting of your strings.

Input/Output Redirection SUPER POWER!!!!
There are always three default files/streams that are open, and 'resets' after each use
stdin  - standard in, the keyboard
stdout - standard out, outputs to the screen
stderr - standard error, outputs to the screen

When we use 'echo' its output is going to stdout, which is why we visually see it in the console. However, we can redirect that output and use it in other commands, or create files from it.

# notice none of these commands outputs anything to the screen
# > overwrites, or creates a new file
# >> appends, or creates a new file
echo '// comment inside file1' > file1.txt
echo '// overwrites previous comment' > file1.txt
echo '// appends this comment' >> file1.txt

Filename expansion, aka 'globbing', are useful for creating a list
# astericks * are wilds cards
# question marks ? are any single char
touch testfile.js  # creates a file named 'testfile.js'
ls *.js            # outputs every js file in your current dir
ls testf*.js       # outputs: testfile.js
echo t*ile.js      # outputs: testfile.js
echo t???file.js   # outputs: testfile.js
echo ./*.js        # same as above, but prefixed with ./ for other cmds


Bringing it all together
So far we have covered variable expansion, for-loop structure, globbing, and redirection.
for file in ./*/*.js
do
  echo "// comment" >> "$file"
done

# line1 the first asterick looks through all the folders
# line1 globbing creates a list of js files one subdirectory deep
# line3 redirects the output of the string and appends it to the list of files
# line3 "$file" is enclosed in quotes because IF you had a filename that had spaces, it would break the globbing function.

Thank you for reading, there's some more bonus stuff below if you're curious about math and how things break!

BONUS / Common gotchas!
# for basic arithmetic (no floats), wrap the expression in double parens
((i=0))  # spaces within the double parens are ok
echo $i  # outputs 0
((i=i+1))  # $ is not necessary
echo $i    # outputs 1
echo $((i+=1)) # prefix with $ for interactive use, outputs: 2

Variables that are expanded could be executed as a command
name=greg
$name             # error: 'greg' command not found
myPrint=echo
$myPrint "$name"  # outputs: greg

myPrint="echo"
$myPrint "$name"   # outputs: greg
$myPrint $myPrint  # outputs: echo

Use braces to 'protect' your variables when expanding in dbl quotes
echo "${name}ory"  # outputs: gregory
echo "$nameory"    # blank
echo '${name}ory'  # outputs: ${name}ory

Alternatively, you can use 'cat' (concatenation) and redirect the output of a whole file to another file.


Bonus: Create a script to git fetch upstream for specific git repositories



Biblio and resources: 

 To get a better mental model of the differences and terminology use between shell/bash/console/terminal/tty, check out this stack exchange answer: http://unix.stackexchange.com/questions/4126/what-is-the-exact-difference-between-a-terminal-a-shell-a-tty-and-a-con?newreg=662292c76b484f2f8cb55ba57ce16c7a 

Global / environment variables: http://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html

A quick yet thorough guide to writing scripts using bash: http://www.panix.com/~elflord/unix/bash-tute.html

"Why is printf better than echo" http://unix.stackexchange.com/questions/65803/why-is-printf-better-than-echo

"Semicolons superfluous at the end of a line?" http://stackoverflow.com/questions/7507038/semicolons-superfluous-at-the-end-of-a-line-in-shell-scripts

Math in bash: http://www.sal.ksu.edu/faculty/tim/unix_sg/bash/math.html

Shell parameter and variable expansion: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_04.html#sect_03_04_03

IO redirection http://www.tldp.org/LDP/abs/html/io-redirection.html

