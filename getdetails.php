
<html>
<body>
  <center><h2>
    <br><br><br>  <br><br><br>  <br><br><br>
<?php
$db = mysqli_connect('localhost','balaji','spiderman','copper')
or die('Error connecting to MySQL server.');
$v1=$_POST["complaint_id"];
$query = "select complaint_id,name,status from complaint where complaint_id='$v1'";
mysqli_query($db,$query) or die('Error querying database.');
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);
echo 'ID : ' .$row['complaint_id'] . '<br>NAME : ' . $row['name'] . '<br>STATUS : ' .$row['status']. ' <br><br><br><br><br> STATUS <br>0-REJECTED <br>1-UNDERGOING <br>2-COMPLETED <br />'
?>
</center></h2>
</body>
</html>
