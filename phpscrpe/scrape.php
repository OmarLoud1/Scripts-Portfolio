<?php
if (isset($_GET['url'])) {
    $url = $_GET['url'];
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    $html = curl_exec($ch);
    curl_close($ch);

    // Include the simple_html_dom parser
    require_once 'simple_html_dom.php';
    $dom = str_get_html($html);

    $stats = [
        'imageCount' => count($dom->find('img')),
        'internalLinks' => 0,
        'externalLinks' => 0,
        'scriptCount' => count($dom->find('script')),
        'styleSheetCount' => count($dom->find('link[rel="stylesheet"]')),
        'totalLinks' => 0,
        'uniqueDomains' => []
    ];

    foreach ($dom->find('a') as $element) {
        $href = $element->href;
        if (!empty($href)) {
            $stats['totalLinks']++;
            $parsedUrl = parse_url($href);
            $host = $parsedUrl['host'] ?? null;
            if (strpos($href, 'mailto:') === 0) {
                // Handle mailto links
            } elseif ($host === parse_url($url, PHP_URL_HOST)) {
                $stats['internalLinks']++;
            } elseif ($host) {
                $stats['externalLinks']++;
                $stats['uniqueDomains'][$host] = true;
            }
        }
    }

    $stats['uniqueDomains'] = count($stats['uniqueDomains']);

    echo '<pre>' . print_r($stats, true) . '</pre>';
}
?>
