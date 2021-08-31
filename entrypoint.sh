#!/bin/bash

chown named:named --recursive /etc/bind /var/log/bind
named -c /etc/bind/named.conf -g -u named