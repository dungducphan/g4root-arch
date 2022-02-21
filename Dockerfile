FROM dungphan90/g4root-arch:latest
RUN rm -rf /var/lib/apt/list/*
RUN rm -rf /opt/Geant4
ENTRYPOINT entry.sh
