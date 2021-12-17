FROM ubuntu:18.04

RUN apt-get update



USER root 
ADD entrypoint.sh .
ADD data/ ./DATA
RUN chmod +x entrypoint.sh 

EXPOSE 8091

ENTRYPOINT ["./entrypoint.sh"]