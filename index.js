const express = require('express');
const http = require('http');

const app = express();
const port = 3000;

// Logowanie informacji o uruchomieniu serwera
const server = http.createServer(app);
server.listen(port, () => {
    console.log(`Serwer uruchomiony na porcie ${port}`);
    console.log(`Autor serwera: Jakub Kopacki`);
    console.log(`Data uruchomienia: ${new Date().toLocaleString()}`);
});

// Middleware zwracający stronę informacyjną dla klienta
app.get('/', (req, res) => {
    const clientIP = req.ip;

    fetch(`https://ipapi.co/${clientIP}/json/`)
        .then(response => response.json())
        .then(data => {
            const userTimezone = data.timezone;
            const clientTime = new Date().toLocaleTimeString('pl-PL', { timeZone: userTimezone });

            const htmlResponse = `
                <html>
                    <head>
                        <title>Informacje o kliencie</title>
                    </head>
                    <body>
                        <h1>Informacje o kliencie</h1>
                        <p>Adres IP klienta: ${clientIP}</p>
                        <p>Data i godzina w strefie czasowej klienta: ${clientTime}</p>
                    </body>
                </html>
            `;

            res.send(htmlResponse);
        })
        .catch(error => {
            console.error('Błąd podczas uzyskiwania danych o lokalizacji:', error);
            res.status(500).send('Nie można uzyskać informacji o lokalizacji klienta.');
        });
});
