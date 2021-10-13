#!/bin/sh
issues_url="https://api.github.com/repos/gitgrub/NMap-Action/issues"
scan_url="84.115.234.41"
#nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL scan.txt --oN outputfile.txt
#nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL /scan.txt --oN outputfile.txt
#nmap $scan_url --oN outputfile.txt
nmap -iL /scan.txt --oN outputfile.txt
# --oN    output normal
# -sV     Attempts to determine the version of the service running on port
# --open  Only show open (or possibly open) ports
# -iL     Scan targets from a file
# -A
echo =cat outputfile.txt ========================================================
cat outputfile.txt
echo =cat========================================================================

hosts=$(sed ':a;N;$!ba;s/\n/, /g' /scan.txt)

title="NMAP Scan *$hosts* on $(TZ=GST-1GDT date "+%D %T")"
#body=$(sed '1d;s/"/\\"/g;:a;N;$!ba;s/\n/\\n/g' outputfile.txt)
p1="<pre>"
p2="</pre>"
body=$(sed ':a;N;$!ba;s/\n/<br>/g' outputfile.txt)
body=$p1$body$p2
data="{\"title\":\"$title\",\"body\":\"$body\"}"

echo - data ---------------------------------------------------------
echo $data
echo - data ---------------------------------------------------------

curl -X "POST" \
     -H "Authorization: token $GH_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     $issues_url \
     -d "$data"
