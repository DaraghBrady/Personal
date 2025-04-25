<?php
    include('db_connect.php');

    $tableName = $_POST['tableName'];

    $tableInfo = [];
    $tableInfo['Suppliers'] = [
        'headers' => ['Supplier ID', 'Supplier Name', 'Supplier Address', 'Supplier Telephone Number'],
        'fields' => ['supplier_id', 'supplier_name', 'supplier_address', 'supplier_telephone_number']
    ];
    $tableInfo['Customers'] = [
        'headers' => ['Customer ID', 'Customer Name', 'Customer Address', 'Customer Email'],
        'fields' => ['customer_id', 'customer_name', 'customer_address', 'customer_email']
    ];
    $tableInfo['Orders'] = [
        'headers' => ['Order ID', 'Order Date']
        'fields' => ['order_id','order_date']
    ];
    $tableInfo['Products'] = [
        'headers' => ['Product ID', 'Product Name', 'Product Price' , 'Quantity in Stock'],
        'fields' => ['product_id','product_name','product_price','quantity_in_stock']
    ];
    $tableInfo['Order_Product'] = [
        'headers' => ['Quantity Ordered'],
        'fields' => ['quantity_ordered']
    ]

    if (isset($tableInfo[$tableName])) {
        echo "<h2>Add a new record to $tableName</h2>
              <form action='process_add_data.php' method='post'>
                <input type='hidden' name='tableName' value='$tableName'>";

        foreach ($tableInfo[$tableName]['fields'] as $field) {
            echo "$field: <input type='text' name='$field' required><br>";
        }

        echo "<input type='submit' value='Add Record'>
              </form>";

        echo "<h2>$tableName Data</h2>
              <table>
                <tr>";

        foreach ($tableInfo[$tableName]['headers'] as $header) {
            echo "<th>$header</th>";
        }

        echo "</tr>";

        foreach ($all_queries as $one_query) {
            echo "<tr>";
            foreach ($tableInfo[$tableName]['fields'] as $field) {
                echo "<td>{$one_query[$field]}</td>";
            }
            echo "</tr>";
        }

        echo "</table>";
    } else {
        echo "Invalid table selection.";
    }

    mysqli_close($conn);
?>
