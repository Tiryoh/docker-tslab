FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN apt-get update -q && \
	apt-get upgrade -yq && \
	apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata gosu && \
	rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
	apt-get install -y nodejs python3-pip && \
	rm -rf /var/lib/apt/lists/*
RUN pip3 install jupyter jupyterlab && \
	jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
	jupyter labextension install @jupyterlab/statusbar && \
	jupyter lab --generate-config
RUN npm install -g tslab
RUN /usr/bin/tslab install && \
	jupyter kernelspec list
ENV USER=ubuntu
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
