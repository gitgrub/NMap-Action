#!/bin/sh
issues_url="https://api.github.com/repos/gitgrub/NMap-Action/issues"
#nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL scan.txt --oN outputfile.txt
#nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL /scan.txt --oN outputfile.txt
nmap www.nivea.de --oN outputfile.txt
# --oN    output normal
# -sV     Attempts to determine the version of the service running on port
# --open  Only show open (or possibly open) ports
# -iL     Scan targets from a file
# -A

title="NMAP Scan on $(TZ=GST-1GDT date "+%D %T")"
body=$(sed '1d;s/"/\\"/g;:a;N;$!ba;s/\n/\\n/g' outputfile.txt)
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo $body
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
body="servus\nkarli"
#body=$(cat outputfile.txt)
#-----------------------------------
body="<pre> \
# Nmap 7.60 scan initiated Sun Oct 10 21:41:40 2021 as: nmap --oN outputfile.txt www.nivea.de \n \
Nmap scan report for www.nivea.de (151.101.194.221) \n \
Host is up (0.0054s latency). \n \
Other addresses for www.nivea.de (not scanned): 151.101.130.221 151.101.66.221 151.101.2.221 \n \
Not shown: 998 filtered ports \n \
PORT    STATE SERVICE \n \
80/tcp  open  http \n \
443/tcp open  https \n \
# Nmap done at Sun Oct 10 21:41:57 2021 -- 1 IP address (1 host up) scanned in 17.53 seconds \n \
</pre>"
#-----------------------------------

data="{\"title\":\"$title\",\"body\":\"$body\"}"

echo =cat========================================================================
echo =cat========================================================================
cat outputfile.txt
echo =cat========================================================================
echo =cat========================================================================

curl -X "POST" \
     -H "Authorization: token $GH_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     $issues_url \
     -d "$data"
