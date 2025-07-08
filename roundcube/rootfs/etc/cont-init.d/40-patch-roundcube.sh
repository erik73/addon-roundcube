#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Roundcube
# This file patches roundcube to disable renewal of the session cookie
# ==============================================================================

if [[ $(bashio::supervisor.version) < "2025.07.2" ]] || [[ "$(bashio::core.version)" < "2025.07.2" ]]; then
  bashio::log.info "Patching Roundcube to disable session cookie renewal"
  sed -i 's/$RCMAIL->session->regenerate_id(false);//' /var/www/roundcube/index.php
fi
