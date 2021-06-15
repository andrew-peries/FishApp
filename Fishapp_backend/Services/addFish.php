<?php
include '../Connection/Connection.php';

$name = $_POST['name'];
$price = $_POST['price'];
$weight = $_POST['weight'];
$description = $_POST['description'];



$conn->query("INSERT into fish(name,price,Weight,description) values('" . $name . "','" . $price . "','" . $weight . "','" . $description . "')");
