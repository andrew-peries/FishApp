<?php
include '../Connection/Connection.php';

$id = $_POST['id'];
$name = $_POST['name'];
$price = $_POST['price'];
$weight = $_POST['weight'];
$description = $_POST['description'];

$conn->query("update fish
 set name='" . $name . "',price='" . $price . "',Weight='" . $weight . "',description='" . $description . "'
where id='" . $id . "'");
