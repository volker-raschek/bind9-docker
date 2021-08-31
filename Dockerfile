FROM docker.io/library/archlinux:latest

RUN pacman \
      --sync \
      --sysupgrade \
      --refresh --noconfirm \
        bind bind-tools

RUN mkdir --parents /etc/bind/zones /var/log/bind && \
    mv /etc/named.conf /etc/bind/named.conf && \
    cp --recursive /var/named/* /etc/bind/zones && \
    sed --in-place --expression 's#directory "/var/named";#directory "/etc/bind/zones";#g' /etc/bind/named.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 53
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]