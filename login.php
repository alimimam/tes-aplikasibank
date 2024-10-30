<?php
include 'config.php';
session_start();

// Function to limit login attempts
function checkLoginAttempts($username) {
    if (!isset($_SESSION['login_attempts'][$username])) {
        $_SESSION['login_attempts'][$username] = 1;
    } else {
        $_SESSION['login_attempts'][$username]++;
    }
    
    if ($_SESSION['login_attempts'][$username] > 3) {
        return false;
    }
    return true;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // CSRF token validation
    if (!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
        die('CSRF token validation failed');
    }

    $customer_username = filter_input(INPUT_POST, 'customer_username', FILTER_SANITIZE_STRING);
    $customer_pin = $_POST['customer_pin'];

    if (checkLoginAttempts($customer_username)) {
        $stmt = $conn->prepare("SELECT id, customer_name, customer_pin FROM m_customer WHERE customer_username = ?");
        $stmt->bind_param("s", $customer_username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            if (password_verify($customer_pin, $row['customer_pin'])) {
                $_SESSION['customer_id'] = $row['id'];
                unset($_SESSION['login_attempts'][$customer_username]);
                header("Location: dashboard.php");
                exit();
            } else {
                $error = "Incorrect PIN. Please try again.";
            }
        } else {
            $error = "Username not found.";
        }
    } else {
        $error = "Too many login attempts. Please try again later.";
    }
}

// Generate CSRF token
$_SESSION['csrf_token'] = bin2hex(random_bytes(32));
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Swift Pay Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="style/stylelogin.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
        .login-btn {
            width: 100%;
            background-color: #6B21A8;
            color: white;
            font-weight: bold;
            padding: 12px 20px;
            border-radius: 0.375rem;
            transition: background-color 0.2s ease;
        }

        .form-container {
            max-height: 80vh; /* Adjusted to prevent full height */
            overflow-y: auto; /* Allow scrolling if content exceeds */
        }
        
        .w-full.max-w-md {
    max-width: 400px;
    background-color: #ffffff;
    border-radius: 0.5rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 1);
}
    </style>
</head>
<body class="bg-white h-screen flex items-center justify-center">
    <div class="w-full max-w-md mx-auto p-6 bg-white shadow-lg rounded-lg flex flex-col form-container">
        <div>
            <h1 class="text-2xl font-bold mb-6 text-center">E-Banking Kelompok 2 rorrrr</h1>
            <h2 style="text-align:center; margin-top:-20px; margin-bottom:25px;">Masuk Untuk Melanjutkan</h2>
            <form method="POST" action="">
                <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                <div class="mb-4">
                    <label for="customer_username">Username</label>
                    <input class="input-field" name="customer_username" type="text" required />
                </div>
                <div class="mb-4 relative">
                    <label for="customer_pin">Password</label>
                    <input class="input-field" name="customer_pin" type="password" required autocomplete="off" id="password" />
                </div>
                </div>
                <?php if (isset($error)) echo "<p class='text-red-500 text-center mb-4'>$error</p>"; ?>
                <div class="mt-6">
                    <button type="submit" class="login-btn">Login</button>
                </div>
            </form>
        </div>
    </div>
    <script>
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye-slash');
        });
    </script>
</body>
</html>
