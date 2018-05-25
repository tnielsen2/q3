FROM alpine:latest as builder
MAINTAINER jberrenberg v1.3

# to reduce image size all build and cleanup steps are performed in one docker layer
RUN \
  echo "# INSTALL DEPENDENCIES ##########################################" && \
  apk add --update curl g++ gcc git tmux make && \
  mkdir -p /tmp/build && \
  echo "# FETCH INSTALLATION FILES ######################################" && \
  curl https://raw.githubusercontent.com/ioquake/ioq3/master/misc/linux/server_compile.sh -o /tmp/build/compile.sh && \
  curl https://ioquake3.org/data/quake3-latest-pk3s.zip --referer https://ioquake3.org/extras/patch-data/ -o /tmp/build/quake3-latest-pk3s.zip && \
  echo "# NOW THE INSTALLATION ##########################################" && \
  echo "y" | sh /tmp/build/compile.sh && \
  unzip /tmp/build/quake3-latest-pk3s.zip -d /tmp/build/ && \
  cp -r /tmp/build/quake3-latest-pk3s/* ~/ioquake3

FROM alpine:latest
RUN adduser ioq3srv -D
COPY --from=builder /root/ioquake3 /home/ioq3srv/ioquake3
COPY pak0.pk3 /home/ioq3srv/ioquake3/baseq3
COPY q3config_server.cfg /home/ioq3srv/ioquake3/baseq3
USER ioq3srv
EXPOSE 27960/udp
ENTRYPOINT ["/home/ioq3srv/ioquake3/ioq3ded.x86_64"]
CMD ["+set dedicated 1 +exec q3config_server.cfg +map q3dm3"]
