document.addEventListener('DOMContentLoaded', () => {
    const apiUrl = `https://raw.githubusercontent.com/fentwin/devlogtest/main/devlog.json`;

    fetch(apiUrl)
        .then(response => response.json()) 
        .then(data => {
            const addedItems = (data.added || [])
                .filter(item => item.trim() !== '')
                .map(item => `<span class="added devlogtext">${item.trim()}</span>`)
                .join('<br>'); 
            document.getElementById('added-info').innerHTML = addedItems;

            const removedItems = (data.removed || [])
                .filter(item => item.trim() !== '')
                .map(item => `<span class="removed devlogtext">${item.trim()}</span>`)
                .join('<br>');
            document.getElementById('removed-info').innerHTML = removedItems;

          
        })
        .catch(error => console.error('Error fetching data:', error));
});