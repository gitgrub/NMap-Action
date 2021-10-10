#!/bin/sh
issues_url="https://api.github.com/repos/gitgrub/NMap-Action/issues"

#nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL scan.txt --oN outputfile.txt
#nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL /scan.txt --oN outputfile.txt
nmap www.nivea.de --oN outputfile.txt


# --oN    output normal
# -sV     Attempts to determine the version of the service running on port
# --open  Only show open (or possibly open) ports
# -iL     Scan targets from a file
# 

title="NMAP Scan on $(date "+%D %T")"
body=$(sed '1d;s/"/\\"/g;:a;N;$!ba;s/\n/\\n/g' outputfile.txt)

data="{\"title\":\"$title\",\"body\":\"$body\"}"

echo -----------------
echo $GH_TOKEN
echo $TTEST
echo -----------------

#curl -i -H "Authorization: token $GITHUB_TOKEN" -d "$data" $issues_url
#curl -i -H "Authorization: token $GH_TOKEN" -d "$data" $issues_url

echo =cat========================================================================
cat outputfile.txt
echo =cat========================================================================

curl -X "POST" \
     -H "Authorization: token $GH_TOKEN" \
     -H "Content-Type: text/plain; charset=utf-8" \
     $issues_url \
     -d '{"title":$title,"body":"huhu willi"}'
     
