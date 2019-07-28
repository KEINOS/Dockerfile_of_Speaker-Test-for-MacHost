FROM debian:sid-slim

LABEL maintainer "KEINOS https://github.com/KEINOS" \
      usage "https://github.com/KEINOS/Dockerfile_of_Speaker-Test-for-MacHost" \
      author "Jessie Frazelle <jess@linux.com>" \
      contributors "https://github.com/KEINOS/Dockerfile_of_Speaker-Test-for-MacHost/graphs/contributors"

RUN apt-get update && apt-get install -y \
	alsa-utils \
	libasound2 \
	libasound2-plugins \
	pulseaudio \
	pulseaudio-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/pulseaudio
ENV PULSE_SERVER docker.for.mac.localhost

RUN useradd --create-home --home-dir $HOME pulseaudio \
	&& usermod -aG audio,pulse,pulse-access pulseaudio \
	&& chown -R pulseaudio:pulseaudio $HOME
COPY script/run-speaker-test.sh $HOME/run-speaker-test.sh

WORKDIR $HOME
USER pulseaudio

COPY conf/default.pa /etc/pulse/default.pa
COPY conf/client.conf /etc/pulse/client.conf
COPY conf/daemon.conf /etc/pulse/daemon.conf

#ENTRYPOINT [ "pulseaudio" ]
#CMD [ "--log-level=4", "--log-target=stderr", "-v" ]

ENTRYPOINT [ "./run-speaker-test.sh" ]
