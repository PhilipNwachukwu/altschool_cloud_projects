<!DOCTYPE html>
<html>
    <body>
        <h1> My Altschool Holiday Project</h1>
        <div>
        <h2>
            <?php
                date_default_timezone_set("Africa/Lagos");
                echo "The hostname of the server processing this request is: ".gethostname();
            ?>
        </h2>
        </div>
    </body>
</html>
