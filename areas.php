

<html>
<body>
<?php
$db = mysqli_connect('localhost','balaji','spiderman','copper')
or die('Error connecting to MySQL server.');

$query = "SELECT * FROM areas";
mysqli_query($db, $query) or die('Error querying database.');

$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);

echo "<h1><center>DETAILS</CENTER></H1>";
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);
echo " <TABLE width='400' border=1 align=center color=800000>

<TR>
<TH width='5' bgColor=#89EFFE align=middle><pre>AREA ID</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>AREA NAME</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>PINCODE</TH>
</TR>";

echo "<tr>
<td>".$row['AREA_ID']."</td>
<td>".$row['AREA_NAME']."</td>
<td>".$row['PINCODE']."</td>
</tr>";
$row = mysqli_fetch_array($result);

while($row=mysqli_fetch_array($result))
{
echo " <tr>
<td>".$row['AREA_ID']."</td>
<td>".$row['AREA_NAME']."</td>
<td>".$row['PINCODE']."</td>
</tr> ";


}
echo"</Table>";

 ?>
 </body>
 </html>
