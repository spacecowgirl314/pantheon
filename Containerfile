ARG SOURCE_IMAGE="${SOURCE_IMAGE:-base-main}"
ARG SOURCE_ORG="${SOURCE_ORG:-ghcr.io/ublue-os}"
ARG BASE_IMAGE="${SOURCE_ORG}/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

# Build in one step
RUN curl -Lo /etc/yum.repos.d/terra.repo \
        https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo && \
    # Pantheon Apps
    rpm-ostree install \
        elementary-code \
        elementary-music \
        elementary-photos \
        elementary-sideload && \
    # Pantheon
    rpm-ostree install \
        contractor \
        elementary-files \
        elementary-files-portal \
        elementary-greeter \
        elementary-icon-theme \
        elementary-notifications \
        elementary-onboarding \
        elementary-print \
        elementary-settings-daemon \
        elementary-shortcut-overlay \
        elementary-sound-theme \
        elementary-terminal \
        elementary-theme \
        elementary-wallpapers \
        gala \
        gvfs \
        gvfs-afc \
        gvfs-afp \
        gvfs-fuse \
        gvfs-gphoto2 \
        gvfs-mtp \
        gvfs-nfs \
        gvfs-smb \
        light-locker \
        pantheon-agent-geoclue2 \
        pantheon-agent-polkit \
        pantheon-session-settings \
        plank \
        touchegg \
        wingpanel \
        wingpanel-indicator-bluetooth \
        wingpanel-indicator-datetime \
        wingpanel-indicator-keyboard \
        wingpanel-indicator-network \
        wingpanel-indicator-nightlight \
        wingpanel-indicator-notifications \
        wingpanel-indicator-power \
        wingpanel-indicator-session \
        wingpanel-indicator-sound \
        zeitgeist-libs && \
    rpm-ostree install \
        gnome-keyring NetworkManager-tui \
        NetworkManager-openvpn && \
    #systemctl disable gdm || true && \
    #systemctl disable sddm || true && \
    #systemctl enable lightdm || true && \
    ostree container commit && \
    mkdir -p /var/tmp && chmod -R 1777 /var/tmp
