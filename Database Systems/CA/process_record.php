<?php
    include('db_connect.php');

    // Get the selected table name from the form
    $tableName = $_POST['tableName'];

    // Check the selected table and perform actions accordingly
    if ($tableName == 'Suppliers')
        <table>
            <tr>
                <th>Supplier ID</th>
                <th>Supplier Name</th>
                <th>Supplier Address</th>
                <th>Supplier Telephone Number</th>
            </tr>

            <?php foreach ($all_queries as $one_query) : ?>
                <tr>
                    <td><?php echo $one_query['supplier_id']; ?></td>
                    <td><?php echo $one_query['supplier_name']; ?></td>
                    <td><?php echo $one_query['supplier_address']; ?></td>
                    <td><?php echo $one_query['supplier_telephone_number']; ?></td>	
                </tr>
            <?php endforeach; ?>
        </table>;
    } elseif ($tableName == 'Customers') {
        <table>
            <tr>
                <th>Customer ID</th>
                <th>Customer Name</th>
                <th>Customer Address</th>
                <th>Customer Email</th>
            </tr>

            <?php foreach ($all_queries as $one_query) : ?>
                <tr>
                    <td><?php echo $one_query['customer_id']; ?></td>
                    <td><?php echo $one_query['customer_name']; ?></td>
                    <td><?php echo $one_query['customer_address']; ?></td>
                    <td><?php echo $one_query['customer_email']; ?></td>	
                </tr>
            <?php endforeach; ?>
        </table>;
    }
     elseif ($tableName == 'Orders') {
        <table>
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
            </tr>

            <?php foreach ($all_queries as $one_query) : ?>
                <tr>
                    <td><?php echo $one_query['order_id']; ?></td>
                    <td><?php echo $one_query['order_date']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>;
    } elseif ($tableName == 'Products') {
        <table>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Product Price</th>
                <th>Quantity in Stock</th>
            </tr>

            <?php foreach ($all_queries as $one_query) : ?>
                <tr>
                    <td><?php echo $one_query['product_id']; ?></td>
                    <td><?php echo $one_query['product_name']; ?></td>
                    <td><?php echo $one_query['product_price']; ?></td>
                    <td><?php echo $one_query['quantity_in_stock']; ?></td>	
                </tr>
            <?php endforeach; ?>
        </table>;
    } elseif ($tableName == 'Order_Product') {
        <table>
            <tr>
                <th>Quantity Ordered</th>
            </tr>

            <?php foreach ($all_queries as $one_query) : ?>
                <tr>
                    <td><?php echo $one_query['quantity_ordered']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>;
    } else {
        echo "Invalid table selection.";
    }

    mysqli_close($conn);
?>
