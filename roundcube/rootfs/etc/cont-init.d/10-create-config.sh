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
            < /var/www/roundcube/SQL/mysql.initial.sql
fi
