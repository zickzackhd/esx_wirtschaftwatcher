<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<?php
 $user = "yourusername";
 $pass = "yourpasswort";
 $i = 0;
 $sql = "SELECT * FROM wirtschaft";
try {
   $conn = new PDO('mysql:host=localhost;dbname=yourdbname', $user, $pass);
   foreach ($conn->query($sql) as $row) {
   // print_r ('[' . $i . ', ' . $row['bargeld']. ', ' . $row['bank']. ', ' . $row['firmengeld']. ', ' . $row['blackmoney'] . '],');
   }
  
} catch (PDOException $e) {
   print "Error!: " . $e->getMessage() . "<br/>";
  die();
}
?>




<script type="text/javascript">

    google.charts.load('current', {'packages':['line']});
      google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Day');
      data.addColumn('number', 'Cash');
      data.addColumn('number', 'Bank money');
      data.addColumn('number', 'Society money');
      data.addColumn('number', 'Black money');
       data.addColumn('number', 'Average total money');
      data.addRows([
        <?php
            foreach ($conn->query($sql) as $i => $row) {
              $ges=  ($row['bargeld']+$row['bank']+$row['firmengeld']+$row['blackmoney'])/4;

              echo ('[' .  $i  . ', ' . $row['bargeld']. ', ' . $row['bank']. ', ' . $row['firmengeld']. ', ' . $row['blackmoney'] . ', ' . ($ges) . '],');

            }
        ?>
      ]);
      
      var options = {
        chart: {
          title: 'Economy',
          subtitle: 'Made by ZickZackHD'
        },
        width: 900,
        height: 500
      };
      
      var chart = new google.charts.Line(document.getElementById('linechart_material'));

      chart.draw(data, google.charts.Line.convertOptions(options));
    }

</script>


<div class="col-md-6" id="linechart_material"></div>
