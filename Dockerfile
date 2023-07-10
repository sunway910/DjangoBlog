# docker build -t jeffrey/djangoblog:image20230710 -f Dockerfile .
# docker run -d  -p 8000:8000 -e DJANGO_MYSQL_HOST=172.17.0.1 -e DJANGO_MYSQL_PASSWORD=mysql_pwd -e DJANGO_MYSQL_USER=root -e DJANGO_MYSQL_DATABASE=djangoblog --name djangoblog jeffrey/djangoblog:image20230710
FROM python:3
ENV PYTHONUNBUFFERED 1
WORKDIR /code/djangoblog/
RUN  apt-get install  default-libmysqlclient-dev -y && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
ADD requirements.txt requirements.txt
RUN pip install --upgrade pip  && \
        pip install -Ur requirements.txt  && \
        pip install gunicorn[gevent] && \
        pip cache purge
        
ADD . .
RUN chmod +x /code/djangoblog/bin/docker_start.sh
ENTRYPOINT ["/code/djangoblog/bin/docker_start.sh"]
