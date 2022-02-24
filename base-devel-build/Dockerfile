FROM archlinux:base-devel

RUN pacman -Sy git cmake ninja root go --noconfirm
RUN useradd --shell=/bin/false build && usermod -L build -aG wheel
RUN git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
RUN mkdir /home/build && chown -R build:build /opt/yay-git /home/build
WORKDIR /opt/yay-git
USER build
RUN makepkg -s
USER root

COPY entry.sh /usr/local/bin/entry.sh
# RUN chmod +x /usr/local/bin/entry.sh
ENV PATH="${PATH}:/opt/yay-git/pkg/yay-git/usr/bin/"

RUN mkdir -p /opt/Geant4/build
RUN git clone --branch geant4-11.0-release https://github.com/Geant4/geant4.git /opt/Geant4/src
WORKDIR /opt/Geant4/build/
RUN cmake /opt/Geant4/src/ -GNinja -DGEANT4_INSTALL_DATA=ON 
RUN ninja
RUN ninja install
RUN rm -rf /opt/Geant4
RUN rm -rf /var/lib/apt/lists/*

# WORKDIR /opt/Geant4/build/bin/
RUN ["/bin/sh", "-c", "source geant4.sh"]
ENV CMAKE_PREFIX_PATH="${CMAKE_PREFIX_PATH}:/usr/local/lib/Geant4-11.0.0"

ENTRYPOINT entry.sh
