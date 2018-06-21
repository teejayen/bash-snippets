#!Don't run this...

# Finds large files and sorts by biggest to smallest.
find / -type f -size +20000k -exec ls -lh {} \; 2> /dev/null | awk '{ print $NF ": " $5 }' | sort -nrk 2,2

# Remove empty directories.
find . -type d -empty -print0 | xargs -0 rmdir\

# Find $query recursively in all files in the current directory.
grep -r "$query" .

# Generate a 10MB file with random data.
dd if=/dev/urandom of=10M.out bs=1m count=10

# What is my IP address?
curl icanhazip.com
curl 
dig +short myip.opendns.com @resolver1.opendns.com

# Get all open IPv4 ports by $PID
lsof -i 4 -a -p $PID

# Copy current working directory path (requires xclip)
pwd | tr -d "\r\n" | xclip -selection clipboard

# List 10 most popular commands.
history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}' | sort | uniq -c | sort -n | tail | sort -nr

# Copy file and append -old.
cp /var/www/vhosts/reallylongfilename.config{,-old}

# Make a whole directory tree with one command.
mkdir -p tmp/x/y/z

# Check WordPress versions installed (WHM)
find /home/*/public_html/ -type f -iwholename "*/wp-includes/version.php" -exec grep -H "\$wp_version =" {} \;
