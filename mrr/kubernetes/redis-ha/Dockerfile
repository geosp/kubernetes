FROM redis:5.0.5-buster

MAINTAINER Geovanny Fajardo

RUN apt-get install bash \
    sed
    
RUN mkdir /redis-master && \
    mkdir /redis-slave
COPY ./config/entrypoint.sh /
RUN chmod 777 /entrypoint.sh

CMD [ "/entrypoint.sh" ]

ENTRYPOINT [ "bash", "-c" ]
