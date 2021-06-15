<?php
include '../Connection/Connection.php';

$id = $_POST['id'];

$conn->query("delete from fish where id='$id'");
