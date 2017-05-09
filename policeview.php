

<html>
<body><center>
<?php
$db = mysqli_connect('localhost','balaji','spiderman','copper')
or die('Error connecting to MySQL server.');

$query = "SELECT * FROM police_view where status != 2";
mysqli_query($db, $query) or die('Error querying database.');

$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);

//while ($row = mysqli_fetch_array($result)) {
 //echo $row['complaint_id'] . '|' . $row['name'] . ' | ' . $row['phone_number'] . ' | ' . $row['description'] .' | ' . $row['status'] .'<br />';
//}

echo "<h1><center>DETAILS</CENTER></H1>";
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);
echo " <TABLE width='400' border=1 align=center color=800000>

<TR>

<TH width='5' bgColor=#89EFFE align=middle><pre>complaint_id</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>name</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>phone number</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>description</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>status</TH>
</TR>";

echo "<tr>
<td>".$row['complaint_id']."</td>
<td>".$row['name']."</td>
<td>".$row['phone_number']."</td>
<td>".$row['description']."</td>
<td>".$row['status']."</td>
</tr>";
$row = mysqli_fetch_array($result);

while($row=mysqli_fetch_array($result))
{
echo " <tr>
<td>".$row['complaint_id']."</td>
<td>".$row['name']."</td>
<td>".$row['phone_number']."</td>
<td>".$row['description']."</td>
<td>".$row['status']."</td>
</tr> ";


}
echo"</Table><br><br>";
echo ' STATUS <br>0-REJECTED <br>1-UNDERGOING <br>2-COMPLETED <br />'


 ?>
 </body></center>
 </html>
