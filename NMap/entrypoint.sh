#!/bin/sh
issues_url="https://api.github.com/repos/gitgrub/NMap-Action/issues"

#nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL scan.txt --oN outputfile.txt
nmap  --script nmap-vulners,vulscan --script-args vulscandb=exploitdb.csv -sV --open -iL /scan.txt --oN outputfile.txt

title="NMAP Scan on $(date "+%D %T")"
body=$(sed '1d;s/"/\\"/g;:a;N;$!ba;s/\n/\\n/g' outputfile.txt)

data="{\"title\":\"$title\",\"body\":\"$body\"}"

echo -----------------
echo $GH_TOKEN
echo $TTEST
echo -----------------

#curl -i -H "Authorization: token $GITHUB_TOKEN" -d "$data" $issues_url
#curl -i -H "Authorization: token $GH_TOKEN" -d "$data" $issues_url

curl -X "POST" \
     -H "Authorization: token $GH_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     $issues_url \
     -d '{"title":"title"}'
     
