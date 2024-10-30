<?php
include 'config.php';
session_start();

if (!isset($_SESSION['customer_id'])) {
    header("Location: login.php");
    exit();
}

$customer_id = $_SESSION['customer_id'];
$message = "";
$message_type = "info";

// Fungsi untuk memvalidasi input
function validateInput($input) {
    return htmlspecialchars(trim($input));
}

function currencyToNumber($amount) {
    $amount = str_replace('Rp ', '', $amount);
    $amount = str_replace('.', '', $amount);
    $amount = str_replace(',', '.', $amount);
    return (float) $amount;
}

// Ambil daftar akun customer untuk dropdown
$stmt = $conn->prepare("SELECT account_number, account_type, available_balance FROM m_portfolio_account WHERE m_customer_id = ?");
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$accounts = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $transaction_type = validateInput($_POST['transaction_type']);
    
    if ($transaction_type == 'topup') {
        $to_account_number = validateInput($_POST['topup_account']);
        $amount = currencyToNumber($_POST['topup_amount']);

        if ($amount <= 0) {
            $message = "Jumlah topup harus lebih dari 0!";
            $message_type = "danger";
        } else {
            $stmt = $conn->prepare("SELECT id FROM m_portfolio_account WHERE account_number = ? AND m_customer_id = ? FOR UPDATE");
            $stmt->bind_param("si", $to_account_number, $customer_id);
            $stmt->execute();
            $account = $stmt->get_result()->fetch_assoc();

            if (!$account) {
                $message = "Akun tidak ditemukan!";
                $message_type = "danger";
            } else {
                $conn->begin_transaction();

                try {
                    // Update saldo akun
                    $stmt = $conn->prepare("UPDATE m_portfolio_account SET available_balance = available_balance + ? WHERE id = ?");
                    $stmt->bind_param("di", $amount, $account['id']);
                    $stmt->execute();

                    // Simpan data transaksi
                    $stmt = $conn->prepare("INSERT INTO t_transaction (m_customer_id, transaction_amount, status, transaction_date, from_account_number, to_account_number, transaction_type) VALUES (?, ?, ?, NOW(), ?, ?, 'TOPUP')");
                    $status = 'success';
                    $system_account = 'SYSTEM';
                    $stmt->bind_param("idsss", $customer_id, $amount, $status, $system_account, $to_account_number);
                    $stmt->execute();

                    $conn->commit();
                    $message = "Topup berhasil! Saldo telah ditambahkan ke akun Anda.";
                    $message_type = "success";
                    
                    // Refresh daftar akun
                    $stmt = $conn->prepare("SELECT account_number, account_type, available_balance FROM m_portfolio_account WHERE m_customer_id = ?");
                    $stmt->bind_param("i", $customer_id);
                    $stmt->execute();
                    $accounts = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
                } catch (Exception $e) {
                    $conn->rollback();
                    $message = "Terjadi kesalahan dalam proses topup: " . $e->getMessage();
                    $message_type = "danger";
                }
            }
        }
    }
}

function formatCurrency($amount) {
    return 'Rp ' . number_format($amount, 0, ',', '.');
}

// Ambil saldo total
$stmt = $conn->prepare("SELECT SUM(available_balance) as total_balance FROM m_portfolio_account WHERE m_customer_id = ?");
$stmt->bind_param("i", $customer_id);
$stmt->execute();
$result = $stmt->get_result();
$total_balance = $result->fetch_assoc()['total_balance'];
?>

<html>
<head>
    <title>Ebanking Kelompok 2</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="max-w-4xl mx-auto bg-white shadow-lg rounded-lg overflow-hidden">
        <!-- Header -->
        <div class="flex items-center justify-between p-4 bg-purple-600 text-white">
            <i class="fas fa-bars"></i>
            <h1 class="text-xl font-bold">Bank Lury Asik</h1>
            <i class="fas fa-bell"></i>
        </div>
        
        <!-- Transfer Dana Section -->
        <div class="flex items-center justify-between p-4 bg-purple-600 text-white">
            <i class="fas fa-money-transfer"></i>
            <h1 class="text-xl font-bold">Top Up </h1>
            <i class="fas fa-belsl"></i>
        </div>
        
        <!-- Transfer Form -->
        <div class="p-4">
                    <?php if ($message): ?>
                        <div class="mb-4 p-4 rounded-lg <?= $message_type == 'success' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'; ?>">
                            <?= htmlspecialchars($message); ?>
                        </div>
                    <?php endif; ?>
            <form method="POST" action="">
                <input type="hidden" name="transaction_type" value="topup">
                <div class="mb-4">
                    <select name="topup_account" id="topup_account" 
                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            <?php foreach ($accounts as $account): ?>
                                <option value="<?= htmlspecialchars($account['account_number']) ?>">
                                    <?= htmlspecialchars($account['account_number']) ?> - 
                                    <?= htmlspecialchars($account['account_type']) ?> 
                                    (<?= formatCurrency($account['available_balance']) ?>)
                                </option>
                            <?php endforeach; ?>
                        </select>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700" for="account-type">Tipe Akun</label>
                    <select id="account-type" name="account-type" class="mt-1 block w-full p-2 border border-gray-300 rounded-md" required>
                        <option value="">Pilih tipe akun</option>
                        <option value="savings">Tabungan</option>
                        <option value="checking">Rekening Giro</option>
                        <option value="business">Rekening Bisnis</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700" for="currency-code">Nominal</label>
                    <input  type="text" 
                            name="topup_amount" 
                            id="topup_amount" 
                            class="w-full p-3 pl-9 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" 
                            placeholder="0" 
                            required>
                </div>
                <div class="mb-4">
                    <label class="block text-sm font-medium text-gray-700" for="available-balance">Total Saldo Tersedia</label>
                </div>
                <div class="bg-white p-4 border-b">
            <div class="bg-purple-400 rounded-lg p-4">
                <p class="text-sm text-white">Total Saldo</p>
                <p class="text-2xl font-bold text-white"><?= formatCurrency($total_balance); ?></p>
                <p class="text-xs text-white mt-1">Update terakhir: <?= date('d M Y H:i'); ?></p>
            </div>
        </div>
                <button type="submit" class="w-full bg-purple-600 text-white py-2 rounded-lg hover:bg-purple-600">Kirim</button>
            </form>
        </div>
        <br>
        <br>
    </div>
                <!-- Bottom Navigation -->
                <div class="fixed bottom-0 left-0 right-0 bg-white shadow-lg">
        <div class="flex justify-around p-2">
                <div class="flex flex-col items-center text-purple-700">
                    <i class="fas fa-home"></i>
                    <div class="text-xs">
                        <a href="dashboard.php">Home</a></div>
                </div>
                <div class="flex flex-col items-center text-gray-400">
                    <i class="fas fa-exchange-alt"></i>
                    <div class="text-xs"><a href="transfer.php">Transactions</a></div>
                </div>
                <div class="flex flex-col items-center text-gray-400">
                    <i class="fas fa-credit-card"></i>
                    <div class="text-xs">My Cards</div>
                </div>
                <div class="flex flex-col items-center text-gray-400">
                    <i class="fas fa-cog"></i>
                    <div class="text-xs">Setting</div>
                </div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            new Cleave('#topup_amount', {
                numeral: true,
                numeralThousandsGroupStyle: 'thousand',
                numeralDecimalMark: ',',
                delimiter: '.'
            });
        });
    </script>
</body>
</html>