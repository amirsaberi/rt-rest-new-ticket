#!/bin/bash

scriptdir=/usr/local/scripts/ticket

# Get new tickets
ticketinfo=`curl -s -L "https://rt.com/REST/1.0/search/ticket?query=Queue%20%3D%20%27QUEUE%27%20AND%20Status%20%3D%20%27new%27&user=TEST&pass=TEST" | grep -v "Ok"  | sed '/^$/d' > $scriptdir/tickets.txt`


ticketcount=`cat $scriptdir/tickets.txt  | grep -v '^No' | wc -l`
tn=0

if [ "$ticketcount" -gt "0" ]
then
	#ticketnumber=`cat $scriptdir/tickets.txt | cut -d':' -f1`
	#for i in $ticketnumber; do
	while read line
	do
		ticketsubject=`echo $line | cut -d':' -f2`
		ticketnumber=`echo $line | cut -d':' -f1`
		if [[ $ticketsubject == *"outage"* || $ticketsubject == *"maintenance"* || $ticketsubject == *"planned"* || $ticketsubject == *"activity"* || $ticketsubject == *"bank"* || $ticketsubject == *"billing"* || $ticketsubject == *"interconnect"* || $ticketsubject == *"notification"* || $ticketsubject == *"upgrade"* || $ticketsubject == *"schedule "* || $ticketsubject == *"iTest"* || $ticketsubject == *"Advisory"* || $ticketsubject == *"SMS"* || $ticketsubject == *"Advisory"* || $ticketsubject == *"DELIVERY"* || $ticketsubject == *"DEGRADATION"* ]]
		then
			tn=0

		curl -s -L "https://rt.com/rt/REST/1.0/ticket/$ticketnumber/edit?&user=TEST&pass=TEST" -d $'content=Owner: amirhossein\nStatus: open' &
		else
			let "tn=tn+1"
		fi
	done < $scriptdir/tickets.txt
	echo $tn
else
	echo $tn
fi
