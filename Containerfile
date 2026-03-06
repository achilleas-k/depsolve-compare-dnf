FROM fedora:43

RUN dnf install -y 'dnf*-command(copr)'
RUN dnf -y copr enable @osbuild/osbuild fedora-43-x86_64

# depsolver
RUN dnf install -y osbuild-depsolve-dnf-175-1.20260306112150512392.main.4.gf10ac47a.fc43.x86_64

# libdnf5 for dnf5 depsolver
RUN dnf -y install python3-libdnf5 git

# images dependencies
RUN dnf -y install \
    btrfs-progs-devel \
    device-mapper-devel \
    gcc \
    go \
    gpgme-devel \
    krb5-devel

RUN git clone https://github.com/osbuild/images

WORKDIR images
RUN go build -o /bin/ ./cmd/gen-manifests
WORKDIR /

COPY ./test.sh /test.sh

VOLUME /manifests

ENTRYPOINT /test.sh
