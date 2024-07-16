<?php
// Database settings
define( 'DB_NAME', getenv('DB_NAME') );
define( 'DB_USER', getenv('DB_USER') );
define( 'DB_PASSWORD', getenv('DB_PASSWORD') );
define( 'DB_HOST', getenv('DB_HOST') );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

// WordPress URLs
define( 'WP_HOME', getenv('DOMAIN_NAME') );
define( 'WP_SITEURL', getenv('DOMAIN_NAME') );

// Authentication unique keys and salts
define( 'AUTH_KEY', getenv('AUTH_KEY') );
define( 'SECURE_AUTH_KEY', getenv('SECURE_AUTH_KEY') );
define( 'LOGGED_IN_KEY', getenv('LOGGED_IN_KEY') );
define( 'NONCE_KEY', getenv('NONCE_KEY') );
define( 'AUTH_SALT', getenv('AUTH_SALT') );
define( 'SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT') );
define( 'LOGGED_IN_SALT', getenv('LOGGED_IN_SALT') );
define( 'NONCE_SALT', getenv('NONCE_SALT') );

// WordPress table prefix
$table_prefix = 'wp_';

// Debugging mode
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

// Absolute path to the WordPress directory
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

// Sets up WordPress vars and included files
require_once ABSPATH . 'wp-settings.php';
