<?php
/**
 * Core configurations
 *
 * PHP version 5
 *
 * @category   PHP
 * @package    Restyaboard
 * @subpackage Core
 * @author     Restya <info@restya.com>
 * @copyright  2014-2017 Restya
 * @license    http://restya.com/ Restya Licence
 * @link       http://restya.com/
 */
define('R_DEBUG', true);
ini_set('display_errors', R_DEBUG);
define('R_API_VERSION', 1);
if (!defined('JSON_PRETTY_PRINT')) {
    define('JSON_PRETTY_PRINT', 128);
}
if (!defined('JSON_UNESCAPED_SLASHES')) {
    define('JSON_UNESCAPED_SLASHES', 128);
}
if (!defined('JSON_UNESCAPED_UNICODE')) {
    define('JSON_UNESCAPED_UNICODE', 256);
}
define('APP_PATH', dirname(dirname(dirname(__FILE__))));
// While changing below oAuth credentials, have to update in oauth_clients table also.
if (isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW'])) {
    define('OAUTH_CLIENTID', $_SERVER['PHP_AUTH_USER']);
    define('OAUTH_CLIENT_SECRET', $_SERVER['PHP_AUTH_PW']);
} else {
    define('OAUTH_CLIENTID', '7742632501382313');
    define('OAUTH_CLIENT_SECRET', '4g7C4l1Y2b0S6a7L8c1E7B3K0e');
}
$default_timezone = 'Europe/Berlin';
if (ini_get('date.timezone')) {
    $default_timezone = ini_get('date.timezone');
}
date_default_timezone_set($default_timezone);

define('R_DB_HOST', 'localhost');
define('R_DB_USER', 'root');
define('R_DB_PASSWORD', '');
define('R_DB_NAME', 'restyaboard');
define('R_DB_PORT', 3306);
define('CHAT_DB_HOST', 'localhost');
define('CHAT_DB_USER', 'ejabberd');
define('CHAT_DB_PASSWORD', 'ftfnVgYl2');
define('CHAT_DB_NAME', 'ejabb');
define('CHAT_DB_PORT', '5432');
define('SECURITYSALT', 'e9a556134534545ab47c6c81c14f06c0b8sdfsdf');
define('SITE_LICENSE_KEY', 'REPLACE YOUR LICENCE HERE');

define('LICENSE_HASH', '');
if (!defined('STDIN') && !file_exists(APP_PATH . '/tmp/cache/site_url_for_shell.php') && !empty($_server_domain_url)) {
    $fh = fopen(APP_PATH . '/tmp/cache/site_url_for_shell.php', 'a');
    fwrite($fh, '<?php' . "\n");
    fwrite($fh, '$_server_domain_url = \'' . $_server_domain_url . '\';');
    fclose($fh);
}
$mydsn = 'mysql:dbname='. R_DB_NAME .';host=' . R_DB_HOST .  ';port=' . R_DB_PORT . ';charset=utf8';
try {
    $db_lnk = new PDO($mydsn, R_DB_USER, R_DB_PASSWORD);
    //$db_lnk->query("SET NAMES utf8;");
} catch (PDOException $e) {
    die('Database could not connect');
}

$result = $db_lnk->query('SELECT name, value FROM settings WHERE setting_category_id in (1,2,3,10,11,14) OR setting_category_parent_id in (1,2,3)');

while ($setting = $result->fetch(PDO::FETCH_ASSOC)) {
    define($setting['name'], $setting['value']);
}
$thumbsizes = array(
    'User' => array(
        'micro_thumb' => '16x16',
        'small_thumb' => '32x32',
        'normal_thumb' => '64x64',
        'medium_thumb' => '153x153'
    ) ,
    'Organization' => array(
        'medium_thumb' => '153x153',
        'small_thumb' => '32x32'
    ) ,
    'Board' => array(
        'micro_thumb' => '16x16',
        'small_thumb' => '32x32',
        'medium_thumb' => '153x153',
        'extra_large_thumb' => '2000x1263'
    ) ,
    'CardAttachment' => array(
        'small_thumb' => '108x78',
        'medium_thumb' => '153x153',
        'large_thumb' => '202x151'
    )
);
$aspect['CardAttachment']['large_thumb'] = 1;

/**
 * @param PDO $db
 * @param $query
 * @param $params
 * @return mixed
 */
function pdoQueryFetchAssoc(PDO $db, $query, $params) {
    $stm = $db->prepare($query);
    $stm->execute($params);

    return $stm->fetch(PDO::FETCH_ASSOC);
}

/**
 * @param PDO $db
 * @param string $query
 * @param $params
 * @return array
 */
function pdoQueryFetch(PDO $db, $query, $params = null)
{
    $stm = $db->prepare($query);
    $stm->execute($params);
    $all = $stm->fetchAll(PDO::FETCH_OBJ);

    return $all;
}

/**
 * @param PDO $db
 * @param $query
 * @param $params
 * @return PDOStatement
 */
function pdoQueryStm(PDO $db, $query, $params = null) {
    $stm = $db->prepare($query);
    $stm->execute($params);

    return $stm;
}

/**
 * @param PDO $db
 * @param $query
 * @param $params
 * @return array
 */
function pdoInsert(PDO $db, $query, $params = null) {
    $stm = $db->prepare($query);
    $stm->execute($params);

    return ['id' => $db->lastInsertId()];
}