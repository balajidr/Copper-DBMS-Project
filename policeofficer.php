

<html>
<body><center>
<?php
$db = mysqli_connect('localhost','balaji','spiderman','copper')
or die('Error connecting to MySQL server.');

$query = "SELECT * FROM police_officer";
mysqli_query($db, $query) or die('Error querying database.');

$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);

echo "<h1><center>DETAILS</CENTER></H1>";

echo " <TABLE width='400' border=1 align=center color=800000>

<TR>

<TH width='5' bgColor=#89EFFE align=middle><pre>POLICE ID</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>NAME</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>PHONE NUMBER</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>STATION</TH>
<TH width='5' bgColor=#89EFFE align=middle><pre>STATUS</TH>
</TR>";
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);
echo "<tr>
<td>".$row['POLICE_ID']."</td>
<td>".$row['NAME']."</td>
<td>".$row['PHONE_NUMBER']."</td>
<td>".$row['STATION']."</td>
<td>".$row['STATUS']."</td>
</tr>";
$result = mysqli_query($db, $query);
$row = mysqli_fetch_array($result);

while($row=mysqli_fetch_array($result))
{
echo " <tr>
<td>".$row['POLICE_ID']."</td>
<td>".$row['NAME']."</td>
<td>".$row['PHONE_NUMBER']."</td>
<td>".$row['STATION']."</td>
<td>".$row['STATUS']."</td>
</tr> ";


}
echo" </Table><br><br><br>";

echo ' STATUS <br>0-NOT AVAILABLE <br>1-AVAILABLE  <br />'


 ?></center>
 </body>
 </html>
