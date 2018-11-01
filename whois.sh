#!/bin/bash

function write(){
	file_name=$(echo "$1" | tr "." "_")
	whois="https://www.whois.com/whois/$1"
	echo $whois
	curl $whois > $2/$file_name.html
}

if [ ! $# == 3 ]; then
  echo "Parameters error"
  exit
else
	mkdir -p $1 # если нет директории, указанной пользователем, создаю её
	if [ $2 == "domain" ]; then
		write $3 $1
	elif [ $2 == "file" ]; then
		while read domain; do
			domain=${domain/www./ } #привожу строку к стандартному виду
			domain=${domain%$'\r'}
			domain=${domain/'http://'/ }
			domain=${domain/'https://'/ }
			write $domain $1
		done < $3
		write $domain $1
	else
		echo "Not domain, not file"
		exit
	fi
fi



