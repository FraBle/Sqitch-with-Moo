FROM sqitch/sqitch:v1.3.1
USER root
RUN apt-get -qq update \
    && apt-get -qq --no-install-recommends install libmoo-perl \
    && apt-get clean
USER sqitch
