FROM ubuntu:20.04
MAINTAINER h0ffayyy, https://github.com/h0ffayyy
RUN apt-get update && apt-get install --yes vim build-essential python3 python3-setuptools python3-pip supervisor
RUN pip3 install flask
RUN mkdir -pv /opt/jenkinspot/logs
ADD src/templates /opt/jenkinspot/templates
ADD src/static /opt/jenkinspot/static
ADD src/jenkinspot.py /opt/jenkinspot/jenkinspot.py
ADD src/requirements.txt /opt/jenkinspot/requirements.txt
RUN pip3 install -r /opt/jenkinspot/requirements.txt && chmod +x /opt/jenkinspot/jenkinspot.py
RUN touch /opt/jenkinspot/logs/auth.log
ADD conf/supervise-jenkinspot.conf /etc/supervisor/conf.d/supervise-jenkinspot.conf
CMD ["/usr/bin/supervisord", "-n"]