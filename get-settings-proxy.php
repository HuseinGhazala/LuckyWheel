<?php
/**
 * وكيل بسيط لجلب إعدادات عجلة الحظ من Google Apps Script (يتجاوز CORS).
 * ارفع هذا الملف في نفس مجلد الموقع على الاستضافة (مثلاً بجانب index.html).
 * الطلب: GET get-settings-proxy.php?url=ENCODED_GOOGLE_SCRIPT_URL
 */
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

$url = isset($_GET['url']) ? $_GET['url'] : '';
if (empty($url) || strpos($url, 'script.google.com') === false) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Invalid url parameter']);
    exit;
}

$ctx = stream_context_create([
    'http' => [
        'timeout' => 15,
        'ignore_errors' => true
    ]
]);
$content = @file_get_contents($url, false, $ctx);
if ($content === false) {
    http_response_code(502);
    echo json_encode(['success' => false, 'error' => 'Failed to fetch']);
    exit;
}
echo $content;
