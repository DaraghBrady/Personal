<?php
    $servername = "https://mysql05.comp.dkit.ie/D00255640";
    $username = "D00255640";
    $password = "tDZN4Mmg";
    $dbname = "part3.sql";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
?>
