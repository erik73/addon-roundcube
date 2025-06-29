#!/command/with-contenv bashio
# shellcheck disable=SC2086,SC2016
# ==============================================================================
# Home Assistant Add-on: Mailserver
# Configures mailserver
# ==============================================================================

export host
export password
export port
export username
export database

host=$(bashio::services "mysql" "host")
password=$(bashio::services "mysql" "password")
port=$(bashio::services "mysql" "port")
username=$(bashio::services "mysql" "username")

# Modify config files
sed -i "s#$config\['db_dsnw']\ =#$/config\['db_dsnw']\ = 'mysql://${$username}:${$password}@${$host}/roundcubemail';#g" /var/www/roundcube/config/config.inc.php

# Modify config files for S6-logging
sed -i 's#^ + .*$# + -^auth\\. -^authpriv\\. -mail\\. $T ${dir}/everything#' /etc/s6-overlay/s6-rc.d/syslogd-log/run
sed -i 's#^ + .*$# + -^auth\\. -^authpriv\\. -mail\\. $T ${dir}/everything#' /run/service/syslogd-log/run.user
sed -i 's#^backtick .*$#backtick -D "n20 s1000000 T 1" line { printcontenv S6_LOGGING_SCRIPT }#' /etc/s6-overlay/s6-rc.d/syslogd-log/run
sed -i 's#^backtick .*$#backtick -D "n20 s1000000 T 1" line { printcontenv S6_LOGGING_SCRIPT }#' /run/service/syslogd-log/run.user
sed -i 's#^s6-socklog .*$#s6-socklog -d3 -U -t3000 -x /run/systemd/journal/dev-log#' /etc/s6-overlay/s6-rc.d/syslogd/run
sed -i 's#^s6-socklog .*$#s6-socklog -d3 -U -t3000 -x /run/systemd/journal/dev-log#' /run/service/syslogd/run.user

# Fix permissions
chown -R nginx:nginx /var/www/roundcube


database=$(\
    mariadb \
        -u "${username}" -p"${password}" \
        -h "${host}" -P "${port}" \
        --skip-column-names \
        --skip-ssl \
        -e "SHOW DATABASES LIKE 'roundcubemail';"
)

if ! bashio::var.has_value "${database}"; then
    bashio::log.info "Creating database for Roundcube"
    mariadb \
        -u "${username}" -p"${password}" \
        --skip-ssl \
        -h "${host}" -P "${port}" \
            < /etc/roundcube/createdb.sql
    bashio::log.info "Creating db tables for Roundcube"
    mariadb \
        roundcubemail \
        -u "${username}" -p"${password}" \
        --skip-ssl \
        -h "${host}" -P "${port}" \
            < /var/www/roundcube/SQL/mysql.initial.sql
fi
