FROM debian

# Set up LLMP server
RUN apt update && apt upgrade
RUN apt install lighttpd --assume-yes
RUN apt install php5-cgi php5-mysql --assume-yes
RUN apt install unzip telnet --assume-yes
RUN lighttpd-enable-mod fastcgi
RUN lighttpd-enable-mod fastcgi-php
RUN DEBIAN_FRONTEND=noninteractive apt install mysql-server mysql-client --assume-yes
RUN rm /var/www/html/index.lighttpd.html

# Install LWT
#COPY lwt_v_1_6_1.zip /tmp/lwt.zip
ADD http://downloads.sourceforge.net/project/lwt/lwt_v_1_6_1.zip /tmp/lwt.zip
RUN cd /var/www/html && unzip /tmp/lwt.zip && rm /tmp/lwt.zip
RUN mv /var/www/html/connect_xampp.inc.php /var/www/html/connect.inc.php
RUN chmod -R 755 /var/www/html

EXPOSE 80

CMD /etc/init.d/mysql start && /etc/init.d/lighttpd start && /bin/bash

# docker built -t lwt .
# docker run -it -p 8010:80 lwt
