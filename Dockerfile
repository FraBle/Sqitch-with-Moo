FROM sqitch/sqitch
USER root
RUN apt-get -qq update \
    && apt-get -qq --no-install-recommends install libmoo-perl \
    && apt-get clean
USER sqitch
