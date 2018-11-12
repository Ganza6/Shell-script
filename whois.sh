#!/bin/bash

function write(){
	file_name=$(echo "$1" | cut -f1 -d".") # запрос к серверу будет содержать только доменное имя 2-го уровня
	# если же нужно делать запрос учитывая домен 2-го уровня, то все преобразования с адресом можно было бы опустить,
	# так как сайт сам перенаправляет нас на нужную страницу
	
	whois="https://www.whois.com/whois/$1" 
	curl -L $whois > $2/$file_name.html 
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
			domain=${domain%$'\r'}
			domain=${domain/'http://'/ }
			domain=${domain/'https://'/ }
			domain=${domain/www./ }
			write $domain $1
		done < $3
	else
		echo "Not domain, not file"
		exit
	fi
fi



