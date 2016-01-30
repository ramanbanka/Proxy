if [ $(id -u) -ne 0 ]; then
 echo "This script must be run as root";
 exit 1;
 fi

 if [ $# -eq 4 ]
 then

 grep PATH /etc/environment > lol.t;
 printf \
 "
 http_proxy=http://$3:$4@$1:$2/\n\
 https_proxy=http://$3:$4@$1:$2/\n\
 ftp_proxy=http://$3:$4@$1:$2/\n\
 no_proxy=\"localhost,127.0.0.1,localaddress,.localdomain.com\"\n\
 HTTP_PROXY=http://$3:$4@$1:$2/\n\
 HTTPS_PROXY=http://$3:$4@$1:$2/\n\
 FTP_PROXY=http://$3:$4@$1:$2/\n\
 NO_PROXY=\"localhost,127.0.0.1,localaddress,.localdomain.com\"\n" >> lol.t;

 cat lol.t > /etc/environment;


 printf \
 "Acquire::http::proxy \"http://$3:$4@$1:$2/\";\n\
 Acquire::ftp::proxy \"ftp://$3:$4@$1:$2/\";\n\
 Acquire::https::proxy \"https://$3:$4@$1:$2/\";\n" > /etc/apt/apt.conf.d/95proxies;

 rm -rf lol.t;

 else

 printf "Usage $0 <proxy_ip> <proxy_port> <username> <password>\n";

 fi

