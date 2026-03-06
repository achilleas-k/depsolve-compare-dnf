FROM fedora:43

RUN dnf install -y 'dnf*-command(copr)'
RUN dnf -y copr enable @osbuild/osbuild fedora-43-x86_64
RUN dnf install -y python3-osbuild-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-lvm2-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-container-selinux-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-luks2-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-selinux-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-depsolve-dnf-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-ostree-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-initrd-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64 osbuild-tools-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64

RUN dnf -y install python3-libdnf5 git
RUN dnf -y install \
    btrfs-progs-devel \
    cloud-utils \
    device-mapper-devel \
    libvirt-devel \
    gcc \
    go \
    gpgme-devel \
    krb5-devel \
    podman \
    python3 \
    python3-pip \
    python3-pytest \
    yamllint \
    xz
RUN git clone https://github.com/osbuild/images

COPY ./test.sh /test.sh

VOLUME /manifests

ENTRYPOINT /test.sh
