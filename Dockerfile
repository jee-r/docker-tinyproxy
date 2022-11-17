FROM alpine:3.17

LABEL name="docker-tinyproxy" \
    	maintainer="Jee jee@jeer.fr" \
      description="tinyproxy docker image" \
	    url="https://github.com/jee-r/docker-tinyproxy" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-tinyproxy" \
      org.opencontainers.image.source="https://github.com/jee-r/docker-tinyproxy"

COPY rootfs /

RUN apk update && \
	apk upgrade --no-cache && \
	apk add --upgrade --no-cache \
		tinyproxy \
		curl && \
	chmod +x \
		/usr/local/bin/entrypoint.sh \
		/usr/local/bin/healthcheck.sh && \
	rm -rf /tmp/* /var/cache/apk/* 

EXPOSE 8888
VOLUME /config

HEALTHCHECK --interval=5m --timeout=60s --start-period=30s \
    CMD /usr/local/bin/healthcheck.sh || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["tinyproxy", "-d", "-c", "/config/tinyproxy.conf"]
