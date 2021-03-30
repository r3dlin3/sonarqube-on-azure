FROM sonarqube:8.1-community-beta

# ssh
ENV SSH_PASSWD "root:Docker!"
USER root
RUN apt-get update \
     && apt-get install -y openssh-server dialog --no-install-recommends \
     && rm -rf /var/lib/apt/lists/* \
     && update-rc.d ssh enable \
     && echo "$SSH_PASSWD" | chpasswd 
ADD sshd_config /etc/ssh/
EXPOSE 9000 2222

COPY --chown=sonarqube:sonarqube run.sh "$SONARQUBE_HOME/bin/"
# RUN set -x \
#     && cd  $SONARQUBE_HOME/extensions_save/plugins \
#     && curl -Ls https://api.github.com/repos/dependency-check/dependency-check-sonar-plugin/releases/latest \
#         | grep "browser_download_url.*jar" \
#         | cut -d '"' -f 4 \
#         | xargs curl -OsSK-
    # plugin does not work on 8.1
    # && curl -Ls https://api.github.com/repos/hkamel/sonar-auth-aad/releases/latest \
    #     | grep "browser_download_url.*jar" \
    #     | cut -d '"' -f 4 \
    #     | xargs curl -OsSK-
# USER sonarqube