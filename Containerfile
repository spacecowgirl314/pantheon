ARG SOURCE_IMAGE="${SOURCE_IMAGE:-base-main}"
ARG SOURCE_ORG="${SOURCE_ORG:-ghcr.io/ublue-os}"
ARG BASE_IMAGE="${SOURCE_ORG}/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

# Build in one step
RUN curl -Lo /etc/yum.repos.d/_terra.repo \
        https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo && \
    rpm-ostree install \
        pantheon-desktop && \
    rpm-ostree install \
        gnome-keyring NetworkManager-tui \
        NetworkManager-openvpn && \
    # systemctl disable gdm || true && \
    systemctl disable sddm || true && \
    # systemctl enable lightdm || true && \
    ostree container commit && \
    mkdir -p /var/tmp && chmod -R 1777 /var/tmp
