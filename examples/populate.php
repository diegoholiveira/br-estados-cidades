<?php
/**
 * Exemplo de como popular os dados na estrutura contida no
 * arquivo database.sql
 */

define('__DATA_DIR__', __DIR__.'/../data');

$files      = scandir(__DATA_DIR__);
$database   = new PDO(
    'mysql:host=localhost;dbname=example',
    'login',
    'password',
    array(
        PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES \'UTF8\''
    )
);


foreach ($files as $file) {

    $filename = __DATA_DIR__.'/'.$file;

    if (is_file($filename) == false) {
        continue;
    }

    $state = json_decode(file_get_contents($filename));

    printf(
        'Importing %d cities from %s...',
        count($state->cidades),
        $state->nome
    );
    echo PHP_EOL;

    $database->beginTransaction();

    try {

        $state_stmt = $database->prepare('INSERT INTO tb_state (name, short_name) VALUES (:name, :short_name)');
        $state_stmt->bindValue('name', $state->nome, PDO::PARAM_STR);
        $state_stmt->bindValue('short_name', $state->sigla, PDO::PARAM_STR);
        $state_stmt->execute();

        $state_id = $database->lastInsertId();

        foreach ($state->cidades as $city) {

            $city_stmt = $database->prepare('INSERT INTO tb_city (name, state_id) VALUES (:name, :state)');
            $city_stmt->bindValue('name', $city->nome, PDO::PARAM_STR);
            $city_stmt->bindValue('state', $state_id, PDO::PARAM_INT);
            $city_stmt->execute();
        }

        $database->commit();

    } catch (\Exception $e) {

        $database->rollBack();

        echo 'Please, verify this error: ' . $e->getMessage();
        exit;
    }

}