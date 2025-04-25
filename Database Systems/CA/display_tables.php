<?php
    include('db_connect.php');

   
    $tableName = $_POST['tableName'];

    
    $tableHeaders = [];
    $tableHeaders['Suppliers'] = ['Supplier ID', 'Supplier Name', 'Supplier Address', 'Supplier Telephone Number'];
    $tableHeaders['Customers'] = ['Customer ID', 'Customer Name', 'Customer Address', 'Customer Email'];
    $tableHeaders['Orders'] = ['Order ID', 'Order Date'];
    $tableHeaders['Products'] = ['Product ID', 'Product Name', 'Product Price', 'Quantity in Stock'];
    $tableHeaders['Order_Product'] = ['Quantity Ordered'];

    if (isset($tableHeaders[$tableName])) {
        echo "<table>
                <tr>";
 
        foreach ($tableHeaders[$tableName] as $header) {
            echo "<th>$header</th>";
        }
        
        echo "</tr>";

        foreach ($all_queries as $one_query) {
            echo "<tr>";
            foreach ($one_query as $value) {
                echo "<td>$value</td>";
            }
            echo "</tr>";
        }

        echo "</table>";
    } else {
        echo "Invalid table selection.";
    }

    mysqli_close($conn);
?>
