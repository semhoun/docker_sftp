FROM debian:bookworm

ENV poll_users=true

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
RUN apt-get update && \
    apt-get -y install --no-install-recommends openssh-server && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /var/run/sshd

COPY config/sshd_config /etc/ssh/sshd_config
COPY bin/* /usr/local/bin/


EXPOSE 22
VOLUME ["/data"]
ENTRYPOINT ["/usr/local/bin/setup_environment"]
