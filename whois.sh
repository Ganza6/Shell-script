#!/bin/bash

function write(){
	file_name=$(echo "$1" | tr ". / :" "_")
	whois="https://www.whois.com/search.php?query=$1"
	curl -L $whois > $2/$file_name.html # -L - ��������� ���������
}

if [ ! $# == 3 ]; then
  echo "Parameters error"
  exit
else
	mkdir -p $1 # ���� ��� ����������, ��������� �������������, ������ �
	if [ $2 == "domain" ]; then
		write $3 $1
	elif [ $2 == "file" ]; then
		while read domain; do
			domain=${domain%$'\r'}
			write $domain $1
		done < $3
	else
		echo "Not domain, not file"
		exit
	fi
fi



