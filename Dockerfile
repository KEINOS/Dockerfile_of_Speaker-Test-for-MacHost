FROM keinos/alpine:latest

LABEL \
    maintainer="KEINOS https://github.com/KEINOS" \
    usage="https://github.com/KEINOS/Dockerfile_of_Speaker-Test-for-MacHost" \
    author="Jessie Frazelle <jess@linux.com> & KEINOS https://github.com/KEINOS" \
    contributors="https://github.com/KEINOS/Dockerfile_of_Speaker-Test-for-MacHost/graphs/contributors"

USER root

RUN apk --no-cache add \
    curl \
    alsa-utils \
    alsa-lib \
    alsaconf \
    alsa-plugins-pulse \
    pulseaudio \
    pulseaudio-dev \
    pulseaudio-zeroconf \
    pulseaudio-utils \
    pulseaudio-alsa \
    pulseaudio-jack \
    && rm -rf /var/cache/apk/* /tmp/*

RUN \
    curl -o /usr/local/bin/pulsemixer -jkSL https://raw.githubusercontent.com/GeorgeFilipkin/pulsemixer/master/pulsemixer \
    && chmod +x /usr/local/bin/pulsemixer

ENV \
    HOME=/root \
    PULSE_SERVER=docker.for.mac.localhost

COPY ./script/run-speaker-test.sh $HOME/run-speaker-test.sh
COPY ./conf/default.pa /etc/pulse/default.pa
COPY ./conf/client.conf /etc/pulse/client.conf
COPY ./conf/daemon.conf /etc/pulse/daemon.conf
COPY ./conf/asound.conf /etc/asound.conf

#ENTRYPOINT [ "pulseaudio" ]
#CMD [ "--log-level=4", "--log-target=stderr", "-v" ]

ENTRYPOINT [ "/root/run-speaker-test.sh" ]
