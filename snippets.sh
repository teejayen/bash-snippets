#!Don't run this...

#Finds large files and sorts by biggest to smallest.
find / -type f -size +20000k -exec ls -lh {} \; 2> /dev/null | awk '{ print $NF ": " $5 }' | sort -nrk 2,2
