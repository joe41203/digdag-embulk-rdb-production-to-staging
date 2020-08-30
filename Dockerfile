FROM openjdk:8-jre-alpine

RUN apk add --no-cache libc6-compat python py2-pip coreutils tzdata && \
  cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
  echo "Asia/Tokyo" > /etc/timezone

RUN wget -q https://dl.embulk.org/embulk-0.9.18.jar -O /usr/local/bin/embulk && \
  chmod +x /usr/local/bin/embulk
RUN apk --update add libc6-compat

RUN mkdir /workspace

COPY ./src /workspace/
WORKDIR /workspace/bundle_dir
RUN /usr/local/bin/embulk bundle

WORKDIR /workspace
COPY ./entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
CMD ["entrypoint.sh"]
