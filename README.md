[![](https://images.microbadger.com/badges/image/keinos/speaker-test.svg)](https://microbadger.com/images/keinos/speaker-test "View image details on microbadger.com")
[![](https://img.shields.io/docker/cloud/automated/keinos/speaker-test)](https://hub.docker.com/r/keinos/speaker-test "View on Docker Hub")
[![](https://img.shields.io/docker/cloud/build/keinos/speaker-test)](https://hub.docker.com/r/keinos/speaker-test/builds "View on Docker Hub")

# Speaker-Test for macOS Host

This docker image just plays the test sound of [ALSA](https://en.wikipedia.org/wiki/Advanced_Linux_Sound_Architecture) from the container. Aimed to check, if it plays from the macOS host's speaker.

```bash
docker pull keinos/speaker-test
```

## Requirements

- `pulseaudio` must be installed on your macOS host. Using [Homebrew](https://brew.sh/) is the easiest way.

    ```shellsession
    $ # Install pulseaudio
    $ brew install pulseaudio
    ...
    ```

## How to use

### The easy way

```shellsession
$ cd ~/
$ curl https://KEINOS.github.io/Dockerfile_of_Speaker-Test-for-MacHost/run-test-local.sh -o run-test-local.sh
$ chmod +x $_
$ ./run-test-local.sh
```

### The proper way

1. Be sure that `pulseaudio` is running on host's (macOS') backgroud as a daemon.

    ```shellsession
    $ # Run pulseaudio daemon
    $ pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon
    ...
    ```

2. `pull` or `build` the image.

    ```shellsession
    $ docker pull keinos/speaker-test
    ```

    Or clone the repo and build it locally. Try if your architecture is not x86_64 and get errors.

    ```shellsession
    $ cd ~/
    $ git clone https://github.com/KEINOS/Dockerfile_of_Speaker-Test-for-MacHost.git speaker-test && cd $_
    $ docker build --no-cache -t keinos/speaker-test .
    ```

3. Run the container.

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

- [List of env info that worked](https://github.com/KEINOS/Dockerfile_of_Speaker-Test-for-MacHost/issues/1)
