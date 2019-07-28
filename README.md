![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/keinos/speaker-test)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/keinos/speaker-test)


# Speaker-Test for macOS Host

This docker image just plays a sound test of ALSA from the container. Aimed to check, if it plays from the macOS host's speaker.

```bash
docker pull keinos/speaker-test
```

## Requirements

- `pulseaudio` must be installed on your maOS host. Using [Homebrew](https://brew.sh/) is the easiest way.

    ```shellsession
    $ # Install pulseaudio
    $ brew install pulseaudio
    ...
    ```

## How to use

### The easy way

1. Clone and move into the repo.
2. run the test script.

```shellsession
$ # Move to any working directory
$ cd ~/
$ git clone https://github.com/KEINOS/Dockerfile_of_Speaker-Test-for-MacHost.git speaker-test && cd $_
$ ./run-test-local.sh
```

### The proper way

1. Be sure that `pulseaudio` is running on host's (macOS') backgroud as a daemon.

    ```shellsession
    $ # Run pulseaudio daemon
    $ pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon
    ...
    ```

2. Run the container.

    ```bash
    docker run --rm -it -v ~/.config/pulse:/home/pulseaudio/.config/pulse keinos/speaker-test
    ```

    Be sure that `~/.config/pulse` directory exists in your host and contains files such like below:

    ```shellsession
    $ ls ~/.config/pulse
    YourMachineName.local-card-database.x86_64-apple-darwin18.0.0.simple
    YourMachineName.local-default-sink
    YourMachineName.local-default-source
    YourMachineName.local-device-volumes.x86_64-apple-darwin18.0.0.simple
    YourMachineName.local-runtime
    YourMachineName.local-stream-volumes.x86_64-apple-darwin18.0.0.simple
    ```

3. If you hear "Front, left. Front, right" then it works.

## TIPS

- How to check if the `pulseaudio` daemon is running.

    ```shellsession
    $ # Results if the daemon is running
    $ pulseaudio --check -v
    W: [] caps.c: Normally all extra capabilities would be dropped now, but that's impossible because PulseAudio was built without capabilities support.
    I: [] main.c: Daemon running as PID 18848

    $ # Results if the daemon is NOT running
    $ pulseaudio --check -v
    W: [] caps.c: Normally all extra capabilities would be dropped now, but that's impossible because PulseAudio was built without capabilities support.
    I: [] main.c: Daemon not running
    ```

## Tested Machines

- See Issue #1
