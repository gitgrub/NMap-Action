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
body="servus"
#body=$(cat outputfile.txt)

data="{\"title\":\"$title\",\"body\":\"$body\"}"

#echo -----------------
#echo $GH_TOKEN
#echo $TTEST
#echo -----------------

#curl -i -H "Authorization: token $GITHUB_TOKEN" -d "$data" $issues_url

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
