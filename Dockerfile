FROM centos:7

RUN set -eux; \
  localedef -i en_US -f UTF-8 en_US.UTF-8; \
  echo "[Webmin]" > /etc/yum.repos.d/webmin.repo; \
  echo "name=Webmin Distribution Neutral" >> /etc/yum.repos.d/webmin.repo; \
  echo "#baseurl=http://download.webmin.com/download/yum" >> /etc/yum.repos.d/webmin.repo; \
  echo "mirrorlist=http://download.webmin.com/download/yum/mirrorlist" >> /etc/yum.repos.d/webmin.repo; \
  echo "enabled=1" >> /etc/yum.repos.d/webmin.repo; \
  rpm --import http://www.webmin.com/jcameron-key.asc; \
  yum update -y; \
  yum install -y epel-release; \
  yum update -y; \
  yum install -y bind webmin supervisor; \
  yum clean all

COPY supervisord/supervisord.conf /etc/
COPY supervisord/supervisord_*.ini /etc/supervisor.d/

EXPOSE 80
EXPOSE 53

CMD ["supervisord"]
