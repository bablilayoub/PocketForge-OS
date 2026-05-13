# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/kinoite-main:latest

# Copy OS files before build.sh so systemd services exist
COPY files/ /

### MODIFICATIONS
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

COPY device-profiles/ /usr/share/pocketforge-os/device-profiles/
COPY scripts/firstboot.sh /usr/libexec/pocketforge-os/firstboot.sh

### LINTING
RUN bootc container lint