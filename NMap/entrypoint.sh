#!/bin/sh
issues_url="https://api.github.com/repos/gitgrub/NMap-Action/issues"
ports=$(cat /ports.txt)
#nmap --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL /scan.txt --oN outputfile.txt
#nmap --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -iL /scan.txt --oN outputfile.txt
# 1. port range
nmap -v -O --open -p$ports -iL /scan.txt --oN outputfile.txt

# 2. scripts
#nmap -v -O --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv --open -iL /scan.txt --oN outputfile.txt

# normal
#nmap -v --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv --open -iL /scan.txt --oN outputfile.txt

# test for no response
#nmap -v --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv --open -iL /scan.txt --oN outputfile.txt -Pn

# --oN    output normal
# -sV     Attempts to determine the version of the service running on port
# --open  Only show open (or possibly open) ports
# -iL     Scan targets from a file
# -A
# -O os detection

echo ---------------------------------------------------------------------
echo - outputfile.txt ----------------------------------------------------
echo ---------------------------------------------------------------------
cat outputfile.txt
echo ---------------------------------------------------------------------
echo ---------------------------------------------------------------------


hosts=$(grep -v '^#' /scan.txt)
hosts=$(echo $hosts | sed 's/ /, /g')
title="NMAP Scan *$hosts* on $(TZ=GST-1GDT date "+%d.%m.%Y - %H:%M:%S")"

p1="<pre>Scan ports: $ports<br><br>"
p2="</pre>"
body=$(sed ':a;N;$!ba;s/\n/<br>/g' outputfile.txt)
body=$p1$body$p2
data="{\"title\":\"$title\",\"body\":\"$body\"}"

curl -X "POST" \
     -H "Authorization: token $GH_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     $issues_url \
     -d "$data"
