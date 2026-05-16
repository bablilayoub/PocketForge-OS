# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/kinoite-main:latest AS pocketforge-os

# Copy OS files before build.sh so systemd services and firstboot scripts exist
# before systemctl enable runs.
COPY files/ /
COPY scripts/firstboot.sh /usr/libexec/pocketforge-os/firstboot.sh
COPY scripts/pocketforge-daemon /usr/libexec/pocketforge-os/pocketforge-daemon
COPY apps/pocketforge-control-center/ /usr/share/pocketforge/control-center/
COPY shared/device-profiles/ /usr/share/pocketforge/device-profiles/
COPY shared/performance-profiles/ /usr/share/pocketforge/performance-profiles/

### MODIFICATIONS
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

### LINTING
FROM pocketforge-os AS pocketforge-os-linted
RUN bootc container lint
