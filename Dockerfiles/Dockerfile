FROM erlang:19

ENV ADD_N 100
ENV ADD_SET_N 0
ENV COOKIE "antidote"
ENV CONFIG "/opt/bigdata.config"
ENV ANTIDOTE_NODE "antidote@antidote1"
ENV BENCH_NODE "bench@bench1"
ENV REPO "https://github.com/Chyaboiii/basho_bench.git"
ENV BRANCH "antidote_pb_ccrdts_aws"

RUN set -xe \
  && apt-get update \
  && apt-get install -y --no-install-recommends git openssl ca-certificates \
  && cd /usr/src \
  && git clone $REPO \
  && cd basho_bench \
  && git checkout $BRANCH \
  && make \
  && cp _build/default/bin/basho_bench /opt/basho_bench \
  && cp big_data /big_data \
  && cp examples/antidote_bigdata.config $CONFIG \
  && rm -rf /usr/src/basho_bench /var/lib/apt/lists/*

ADD ./run.sh /opt/
ADD ./entrypoint.sh /

RUN chmod a+x /opt/basho_bench \
  && chmod a+x /entrypoint.sh \
  && chmod a+x /opt/run.sh

# Distributed Erlang Port Mapper
EXPOSE 4368

#VOLUME /opt/antidote/data

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/opt/run.sh"]

