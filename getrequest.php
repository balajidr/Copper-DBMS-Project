
<html>
<body>
<?php
$db = mysqli_connect('localhost','balaji','spiderman','copper')
or die('Error connecting to MySQL server.');
$v1=$_POST["complaint_id"];
$query = "select complaint_id,name,status from complaint where complaint_id='$v1'";
mysqli_query($db,$query) or die('Error querying database.');
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);
echo $row['complaint_id'] . '|' . $row['name'] . ' | ' . $row['status'] .'<br />'
?>
</body>
</html>
