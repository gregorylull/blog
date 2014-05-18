// bash for loop toy problem automate 2014-05-17.md

[john goodman] am i the only one here who wants to resubmit all my toy problems and check what to work on?
####TL;DR Goal - learn how to append lines of code/text to specific files within different sub-directories using bash commands (4 lines!!!)

####TL;DR Solution - run this inside any root directory with immediate sub-directories that contain .js files you want to append to:

    # appends '// comment' to selected .js files
    for file in ./*/*.js
    do
    echo "// comment" >> "$file"
    done
#####Try before you buy:
In case you are not comfortable running the above code, right-click and download [this test script](https://raw.githubusercontent.com/gregorylull/blog/master/bashForLoopToyProblem_2014-05-17/buildDir.sh) to any folder, take a look, then enter the following commands in the console:

    # gives permission to execute the script
    chmod 755 buildDir.sh
    # this executes the script
    ./buildDir.sh

That should get you started, read 5 mins more if you would like to increase your bash stats!

####My backstory, aka my confession:
Two nights ago I did a very anti-programmer thing. I had a git respository that I wanted to re-submit to an automated solution checker. So I opened each file, looked around to remind myself what the file contained, and added a comment.

I did not realize it at the time, but the end result was me manaually adding a comment to 40 files in 40 different directories. 

Shame, guilt, and reflection ensued : It was time for me to go beyond cd and mv.

####Tutorial Intro:
There are a lot of great guides out there for learning Bash, a Unix shell*, so I will cover only what we need to understand the for-loop provided above (...and some fun stuff of course)

####For-loop structure: 
The bash for-loop iterates over space-separated items

    for i in "one" "two" "three"
    do
    echo "$i"  # outputs: one two three
    done

1. A `return` separates commands 
2. semi-colons are for single-line commands:
`for i in "one two three"; do echo "$i"; done;`
3. `echo` automatically adds a newline

####Variable declaration, assignment, and expansion:
*Note:* don't worry about 'polluting' the environment, as soon as you close your terminal window, which is closing an instance of the bash shell, your declared variables will be gone, so have at it!! Also, uppercase is generally reserved for global/environment variables, so just play around with lowercase.

####Declaration and Assignment
Variables are case-sensitive and assignments must have no spaces in between them, otherwise it is interpreted as a command being passed arguments

    name=greg    # works!
    name = greg  # err - name: command not found

####Variable value retrieval and expansion
to retrieve the value of the variable, prefix with a bang $

    name=greg
    echo $name  # outputs: greg
    echo name   # outputs: name

    # variables are expanded within double quotes
    echo "hi $name"  # outputs: hi greg
    echo 'hi $name'  # outputs: hi $name

#####*Note:* I use echo for my examples because it is easier to understand and it automatically adds a newline after the output. However, use printf if you want to have more control over the formatting of your strings.

####Input/Output Redirection SUPER POWER!!!!
There are always three default files/streams that are open, and 'resets' after each use
stdin  - standard in, the keyboard
stdout - standard out, outputs to the screen
stderr - standard error, outputs to the screen

When we use 'echo' its output is going to stdout, which is why we visually see it in the console. However, we can redirect that output and use it in other commands, or create files from it.

    # notice nothing outputs to the screen
    # >  overwrites, or creates a new file
    # >> appends, or creates a new file
    echo '// newly created file' > file1.txt
    echo '// overwrites previous comment' > file1.txt
    echo '// appends this comment' >> file1.txt

####Filename expansion, aka 'globbing', are useful for creating a list

    # * asterisks are wild cards
    # ? question marks are any single char
    touch test.js   # creates a 'test.js' file
    ls *.js         # lists all js file in the dir
    ls te*.js       # lists testfile.js
    echo t???.js    # outputs: testfile.js
    echo ./*.js     # prefixed with ./ for other cmds


####Bringing it all together
So far we have covered variable expansion, for-loop structure, globbing, and redirection.

    for file in ./*/*.js
    do
    echo "// comment" >> "$file"
    done
1. `./*` looks at all immediate sub-directories
2. `/*.js` within each sub-directory, globbing creates a list of .js files
3. `>>` redirects the output of the string and appends it to each of the found .js files
4.`"$file"` is enclosed in quotes because if there was a file with a filename that had spaces (`greg resume.doc`), it would break the globbing function.

Thank you for reading, there's some more bonus stuff below if you're curious about math and how things break!

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

