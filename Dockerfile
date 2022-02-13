FROM archlinux:base-devel

RUN pacman -Sy git cmake ninja --noconfirm
RUN pacman -Sy root --noconfirm
RUN useradd --shell=/bin/false build && usermod -L build
RUN git clone https://aur.archlinux.org/yay-git.git /opt/yay-git
RUN mkdir /home/build
RUN chown -R build:build /opt/yay-git
RUN chown -R build:build /home/build
WORKDIR /opt/yay-git
RUN pacman -Sy go --noconfirm
RUN usermod -aG wheel build
USER build
RUN makepkg -s
USER root

COPY entry.sh /usr/local/bin/entry.sh
RUN chmod +x /usr/local/bin/entry.sh
ENV PATH="${PATH}:/opt/yay-git/pkg/yay-git/usr/bin/"

RUN mkdir -p /opt/Geant4/build
RUN git clone --branch geant4-11.0-release https://github.com/Geant4/geant4.git /opt/Geant4/src
WORKDIR /opt/Geant4/build/
RUN cmake /opt/Geant4/src/ -GNinja -DGEANT4_INSTALL_DATA=ON 
RUN ninja

ENTRYPOINT entry.sh
