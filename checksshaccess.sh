#! bin/bash
IP_FILE="<ip file>"
SSHKEY="<ssh key location>"
[ -f no_auth ] && rm no_auth
[ -f other ] && rm other
[ -f good ] && rm good
for IP in `cat $IP_FILE`;
do

   Status=$(ssh -i $SSHKEY -o ConnectTimeout=10 -o StrictHostKeyChecking=no user@$IP echo ok 2>&1)

    if [[ $Status == ok ]] ; then
        echo $IP >> good

    elif [[ $Status == "Permission denied"* ]] ; then
        echo $IP $Status >> no_auth

    else
        echo $IP $Status >> other

    fi
done
