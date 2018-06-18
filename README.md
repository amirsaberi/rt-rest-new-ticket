# rt-rest-new-ticket
Request Tracker (RT) check for new tickets with REST 1, for using in ZABBIX or other platforms.
I'm using this script for oncall agents that if there was a ticket, then ZABBIX call them. We can also limit specific titles like Maintenance and etc for avoiding high calls.

# Preparation
Don't forget to change the variables in `curl.sh` and replace with yours.

# Usage
``sudo bash curl.sh``
