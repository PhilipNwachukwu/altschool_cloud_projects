<!DOCTYPE html>
<html>
    <body>
        <h1> My Altschool Third Semester Mini Project</h1>
        <div>
        <h2>
            <?php
                date_default_timezone_set("Africa/Lagos");
                echo "The default time zone for this sever is: ".date_default_timezone_get();
            ?>
        </h2>
        <h2>
            <?php
                echo "The hostname of the server processing this request is: ".gethostname();
            ?>
        </h2>
        </div>
    </body>
</html>
