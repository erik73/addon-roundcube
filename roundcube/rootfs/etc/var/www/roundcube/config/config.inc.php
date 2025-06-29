<?php

/* Local configuration for Roundcube Webmail */

$config['db_dsnw'] =

$config['log_driver'] = 'syslog';

$config['syslog_facility'] = LOG_MAIL;

$config['smtp_log'] = false;

$config['imap_host'] = 'localhost:143';

$config['support_url'] = '';

$config['auto_create_user'] = false;

$config['des_key'] = 'MUU5FK7QJejl2Ng3Wg0z1pLd';

$config['plugins'] = ['archive', 'managesieve', 'zipdownload'];

$config['prefer_html'] = false;