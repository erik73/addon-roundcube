<?php

/* Local configuration for Roundcube Webmail */

$config['db_dsnw'] =

$config['log_driver'] = 'syslog';

$config['syslog_facility'] = LOG_MAIL;

// Disable cert verification of the mailserver since we only connect through a docker network
$config['imap_host'] = 'tls://32b8266a-mailserver:143';
$config['imap_conn_options'] = array (
  'ssl' => 
  array (
    'verify_peer' => false,
    'verify_peer_name' => false,
  ),
);

// Disable cert verification of the mailserver since we only connect through a docker network
$config['smtp_host'] = 'tls://32b8266a-mailserver:587';
$config['smtp_conn_options'] = array (
  'ssl' => 
  array (
    'verify_peer' => false,
    'verify_peer_name' => false,
  ),
);

// Disable cert verification of the mailserver since we only connect through a docker network
$config['managesieve_host'] = 'tls://32b8266a-mailserver:4190';
$config['managesieve_conn_options'] = array (
  'ssl' => 
  array (
    'verify_peer' => false,
    'verify_peer_name' => false,
  ),
);

$config['support_url'] = '';

$config['auto_create_user'] = true;

$config['des_key'] = 'MUU5FK7QJejl2Ng3Wg0z1pLd';

$config['plugins'] = ['archive', 'managesieve', 'zipdownload', 'markasjunk'];

$config['managesieve_auth_type'] = 'PLAIN';

$config['managesieve_usetls'] = true;

$config['managesieve_mbox_encoding'] = 'UTF-8';

$config['managesieve_vacation'] = 1;

$config['markasjunk_ham_mbox'] = null;

$config['markasjunk_spam_mbox'] = null;

$config['markasjunk_spam_flag'] = false;

$config['markasjunk_ham_flag'] = false;

$config['prefer_html'] = false;

$config['smtp_log'] = true;

$config['log_logins'] = true;

$config['enable_installer'] = false;

$config['request_path'] = $_SERVER['HTTP_X_INGRESS_PATH'] ?? null;
