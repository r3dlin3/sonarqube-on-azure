FROM sonarqube:8.1-community-beta

RUN set -x \
    && cd  $SONARQUBE_HOME/extensions_save/plugins \
    && curl -Ls https://api.github.com/repos/dependency-check/dependency-check-sonar-plugin/releases/latest \
        | grep "browser_download_url.*jar" \
        | cut -d '"' -f 4 \
        | xargs curl -OsSK-
    # plugin does not work on 8.1
    # && curl -Ls https://api.github.com/repos/hkamel/sonar-auth-aad/releases/latest \
    #     | grep "browser_download_url.*jar" \
    #     | cut -d '"' -f 4 \
    #     | xargs curl -OsSK-