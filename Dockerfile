FROM ubuntu:latest

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends ca-certificates curl \
    && mkdir -p /etc/fahclient && touch /etc/fahclient/config.xml \
    && curl -fsSL https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-arm64/v7.6/fahclient_7.6.21_arm64.deb -o fah.deb \
    && echo "1dc9fa4ca332783c9cafc90a9cb64d36a5bdfd9a69dbb7887cea326b8e79e965 fah.deb" \
      | sha256sum -c --strict - \
    && DEBIAN_FRONTEND=noninteractive dpkg --install --force-depends fah.deb \
    && rm -rf fah.deb \
    && apt-get purge --autoremove -y curl ca-certificates

WORKDIR "/fah"
VOLUME ["/fah"]
EXPOSE 7396 36330

ENTRYPOINT ["/usr/bin/FAHClient", "--chdir", "/fah", "--gpu=false", "--http-addresses", "0.0.0.0:7396", "--allow", "0/0", "--command-allow-no-pass", "0/0", "--web-allow", "0/0"]
