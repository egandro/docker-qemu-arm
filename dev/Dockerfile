ARG TERMUX_DOCKER_IMAGE=termux/termux-docker:latest
FROM ${TERMUX_DOCKER_IMAGE}

# The published image uses its entrypoint to drop privileges, but Docker build
# steps run as root unless the user is set explicitly. pkg refuses to run as
# root.
USER 1000:1000

# Everything that install.sh would normally install on a phone. The debug
# installer is used inside the container, so these packages only need to be
# baked into the image.
RUN pkg update -y && \
    pkg install -y \
        bash \
        curl \
        expect \
        git \
        less \
        openssh \
        qemu-common \
        qemu-system-x86_64-headless \
        qemu-utils \
        vim && \
    pkg clean

# Run the Termux bootstrap second stage during the build. Otherwise its
# profile.d fallback runs on every new container and prints package postinst
# output before every command.
RUN bash -lc ':' && \
    rm -f "$PREFIX/etc/profile.d/01-termux-bootstrap-second-stage-fallback.sh"

# $HOME is backed by a named volume (see run.sh). Create the default VM
# directory at build time so the volume is initialized with the system user
# as owner.
RUN mkdir -p "$HOME/alpine"

WORKDIR /workspace
CMD ["bash", "-l"]
