#!/bin/sh


VPNON=""
while [ -z "$VPNON" ]
do
    # echo
	# echo -e "\e[39mIntroduïu les vostres credencials"
	# echo -e "================================="
    # echo
	# read -e -p "Usuari:"  USERNAME
	# USERNAME="username = $USERNAME"
	# echo -n "Contrasenya":
	# read -s PASSWORD
	# PASSWORD="password = $PASSWORD"
	# echo ""
	# echo "Configurant"
	# echo $HOST > $VPNFILE
	# echo $PORT >> $VPNFILE
	# echo $USERNAME >> $VPNFILE
	# echo $PASSWORD >> $VPNFILE
	# echo $TRUSTED >> $VPNFILE
    # echo
	# echo "Establint connexió VPN"
	VPNON=""
    #sudo openfortivpn -c $VPNFILE > openfortivpn.log 2>&1 &
    sudo openfortivpn $VPN_IP:$VPN_PORT -u $VPN_USER -q -p $VPN_PASS --trusted-cert 1316d13a7122725ecc1d555895053bd1ae8b0c2159e04a1c7c39e4bfb72cbfae > openfortivpn.log 2>&1 &
   COUNT=1
    while [ -z "$VPNON" ]
	do
	    echo -ne "\e[33mCONNECTANT VPN ... $COUNT\033[0K\r"
		VPNON='ip a | grep ppp0'
		if [ ! -z "$VPNON" ]
		then
            echo
			echo -e "\e[32mVPN. Ok "
			break
		fi
		if [ $COUNT -eq 10 ];
		then
			echo ""
			echo ""
			echo -e "\e[31mERROR: No s'ha pogut connectar la VPN. "
			break
		fi
		let COUNT=$COUNT+1
		sleep 1
	done
done