#!/bin/bash

joke=$( curl {http://api.icndb.com/jokes/random} | jq '.value.joke')
echo `curl http://thecatapi.com/api/images/get?format=xml&results_per_page=1` | xmllint --format - > catxml.xml

caturl=$( cat catxml.xml | grep url | sed -e "s/<url>//" | sed -e "s/<\/url>//" )

if [ $caturl = "*.jpg" ]
then
	wget -O kotek.jpg `echo "$caturl"`
	end="jpg"
else
	wget -O kotek.gif `echo "$caturl"`
	end="gif"
fi

clear
echo $joke
img2txt kotek.$end
