// Check if axios is available and load it if not
if (typeof axios === 'undefined') {
    var axiosScript = document.createElement('script');
    axiosScript.src = 'https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js';
    axiosScript.onload = init; // Ensure axios is loaded before attaching events
    document.head.appendChild(axiosScript);
} else {
    init(); // Initialize immediately if axios is already available
}

function init() {
    // Attach the event listener to the form submit event
    document.getElementById('scrapeForm').addEventListener('submit', async function(event) {
        event.preventDefault();
        const urlInput = document.getElementById('urlInput');
        const url = urlInput.value.trim();
        if (!url) {
            alert('Please enter a URL to scrape.');
            return;
        }

        showLoading(true);

        try {
           
            const response = await axios.get(`http://localhost:3000/scrape?url=${encodeURIComponent(url)}`);
            if (response.data) {
                document.getElementById('results').innerHTML = `
                    <p>Image Count: ${response.data.imageCount || 0}</p>
                    <p>Internal Links: ${response.data.internalLinks || 0}</p>
                    <p>External Links: ${response.data.externalLinks || 0}</p>
                    <p>Total Links: ${response.data.totalLinks || 0}</p>
                    <p>Script Tags: ${response.data.scriptCount || 0}</p>
                    <p>Stylesheets: ${response.data.styleSheetCount || 0}</p>
                    <p>Unique Domains: ${response.data.uniqueDomains || 0}</p>
                    <p>Email Links (mailto): ${response.data.mailtoLinks || 0}</p>
                `;
            }
        } catch (error) {
            console.error('Error fetching data:', error);
            document.getElementById('results').innerHTML = '<p class="error">Failed to fetch data. Please try again.</p>';
            alert('Failed to fetch data. Please check the console for more details.');
        }

        showLoading(false);
    });
}

// Function to show or hide the loading screen and results dashboard
function showLoading(show) {
    const loading = document.getElementById('loading');
    const dashboard = document.getElementById('dashboard');
    if (show) {
        loading.style.display = 'block';
        dashboard.style.display = 'none';
    } else {
        loading.style.display = 'none';
        dashboard.style.display = 'block';
    }
}
