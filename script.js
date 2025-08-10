window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.type === 'updateHUD') {
        const locContainer = document.getElementById('location-container');
        locContainer.style.display = 'flex';  // Show container

        document.getElementById('direction').textContent = data.direction || 'N';
        document.getElementById('street').textContent = data.location || 'Unknown';

    } else if (data.type === 'hideHUD') {
        document.getElementById('location-container').style.display = 'none';
    }
});
