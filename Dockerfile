FROM ubuntu:latest
FROM jre:latest
LABEL authors="ajay67"

ENTRYPOINT ["top", "-b"]