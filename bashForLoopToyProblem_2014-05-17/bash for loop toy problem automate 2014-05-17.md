*** 
####TL;DR Goal - learn how to append lines of code/text to specific files within different sub-directories using bash commands

####TL;DR Solution - run this inside the root directory that contain sub-directories of .js files you want to append to:
    # appends '// comment' to selected .js files
    for file in ./*/*.js
    do
      echo "// comment" >> "$file"
    done
#####Try before you buy:
In case you are not comfortable running the code above, right-click and download [this test script](https://raw.githubusercontent.com/gregorylull/blog/master/bashForLoopToyProblem_2014-05-17/buildDir.sh) to any folder, take a look, then enter the following commands in the console:

    # gives permission to execute the script
    chmod 755 buildDir.sh
    # this executes the script
    ./buildDir.sh

That should get you started. Read 5 mins more if you would like to increase your bash stats!

###My backstory, aka my confession:
A couple of nights ago I did a very anti-programmer thing. I had a git repository that I wanted to re-submit to an automated solution checker, so I added a comment to each file and made a pull request. Meaning, I manually added the same comment to 40 files in 40 different directories. 

Shame, guilt, and reflection ensued: It was time for me to go beyond cd, rm, and mv.

####Tutorial Intro:
There are a lot of [great guides](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html#toc5) out there for learning Bash, a Unix shell*, so I will cover only the bare minimum (...and some fun stuff of course).

######*For a better understanding of terminology between shell/bash, console/terminal/tty, check out this [stack exchange answer](http://unix.stackexchange.com/questions/4126/what-is-the-exact-difference-between-a-terminal-a-shell-a-tty-and-a-con?newreg=662292c76b484f2f8cb55ba57ce16c7a )
####Variables:
Do not worry about 'polluting' the environment, your variables will be gone as soon as you close your terminal window, so have at it.
Also, uppercase is generally reserved for [global/environment](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html) variables, so use lowercase variable names.

####Declaration, Assignment, and Expansion
Variables are case-sensitive and assignments cannot have spaces in between them, otherwise it is interpreted as a command being passed arguments

    name=greg    # works!
    name = greg  # err - name: command not found


To retrieve the value of the variable, prefix with a bang $ which 'expands' it

    name=greg
    echo $name  # outputs: greg
    echo name   # outputs: name
    # variables are expanded within double quotes
    echo "hi $name"  # outputs: hi greg
    echo 'hi $name'  # outputs: hi $name

######*Note:* I use echo for my examples because it is visually cleaner and it automatically adds a newline after the output. [Use printf](http://unix.stackexchange.com/questions/65803/why-is-printf-better-than-echo) if you want to have more control over the formatting of your strings.

####For-loop structure: 
The bash for-loop iterates over space-separated items
  
    for i in "one" "two" "three"
    do
      echo "$i" 
    done 
    # outputs: 
    one 
    two
    three

1. `return` separates commands
2. statements between keywords `do` and `done` are executed once per loop
3. semi-colons are necessary for single-line commands:
`for i in "one" "two" "three"; do echo "$i"; done;`



####Input/Output [redirection](http://www.tldp.org/LDP/abs/html/io-redirection.html) SUPER POWER
There are always three default files/streams that are open which 'resets' after each use: standard in (keyboard), standard out (screen), and standard error (screen).

When we use `echo`, its output is going to stdout, which is why we visually see it in the console. However, we can redirect that output and use it in other commands and/or create files from it!

    # again, because we redirect the output, notice
    # that nothing below gets displayed to console
    
    #  >  overwrites, or creates a new file
    echo '// creates file1.txt' > file1.txt
    echo '// overwrites file1.txt' > file1.txt
    
    #  >> appends, or creates a new file
    echo '// appends to end' >> file1.txt

####Filename expansion, aka ['globbing'](http://www.tldp.org/LDP/abs/html/globbingref.html)
This is useful for creating a list/argument that for-loops and other common commands could use. 

    # * asterisks are wildcards
    # ? question marks are any single char
    touch test.js   # creates a 'test.js' file
    ls *.js         # lists .js files in the current dir
    echo t???.js    # outputs: test.js
    echo ./*.js     # prefixed with ./


####Bringing it all together
Let's revisit the solution, everything should make much more sense now:

    for file in ./*/*.js
    do
      echo "// comment" >> "$file"
    done
1. `./*` looks at all immediate sub-directories
2. `/*.js` **globbing** expands the wildcard and finds all .js files within each sub-directory
3. `>>` **redirects** the output of the string and **appends** it to each of the found .js files
#####Common pitfall:
`"$file"` is enclosed in quotes to prevent ambiguity errors. Imagine there were no quotes and if there were a filename that contained spaces (`greg resume.doc`). After `$file` is **expanded**, are you redirecting the output to `greg`, or `greg resume.doc`?

#### Conclusion
Combining what we have learned about variables, the for-loop structure, redirection, and globbing, just imagine all the possibilities out there waiting for you and my future posts!

* for-loops that add boiler plate header and footers to all your original content. **EASY.**
* scripts that alter your git repository history and author information. **SNEAKY?**
* recursively traverse directory trees and .js files to find out the average length of all your variable names using regex.
**WOW!**

Thank you for reading!





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

