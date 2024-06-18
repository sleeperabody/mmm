<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take a Photo</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        #camera-container {
            text-align: center;
        }
        #photo {
            max-width: 100%;
            border: 2px solid #333;
        }
        button {
            padding: 10px 20px;
            font-size: 18px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div id="camera-container">
        <h1>Take a Photo</h1>
        <video id="video" width="640" height="480" autoplay></video>
        <br>
        <button id="snap">Take Photo</button>
        <br>
        <canvas id="canvas" width="640" height="480" style="display:none;"></canvas>
        <br>
        <img id="photo" src="#" alt="Your captured photo will appear here">
    </div>

    <script>
        const video = document.getElementById('video');
        const canvas = document.getElementById('canvas');
        const photo = document.getElementById('photo');
        const snapButton = document.getElementById('snap');

        // Access the user's camera and stream it to the video element
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(function(stream) {
                video.srcObject = stream;
            })
            .catch(function(err) {
                console.log("An error occurred: " + err);
            });

        // Function to take a snapshot from the video stream
        snapButton.addEventListener('click', function() {
            const context = canvas.getContext('2d');
            context.drawImage(video, 0, 0, canvas.width, canvas.height);
            // Capture the image as a data URL and display it in the img element
            const imageDataURL = canvas.toDataURL('image/png');
            photo.setAttribute('src', imageDataURL);
            // Stop the video stream
            video.srcObject.getVideoTracks().forEach(track => track.stop());
            // Hide video and canvas, show the photo
            video.style.display = 'none';
            canvas.style.display = 'none';
            photo.style.display = 'block';
        });
    </script>
</body>
</html>
