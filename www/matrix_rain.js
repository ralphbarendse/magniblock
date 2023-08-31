$(document).on('shiny:connected', function(event) {
  var c = document.getElementById("matrixCanvas");
  var ctx = c.getContext("2d");

  // Making the canvas full screen
  c.height = window.innerHeight;
  c.width = window.innerWidth;

  // The characters
  var matrixChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  matrixChars = matrixChars.split("");

  var font_size = 10; // Increased font size to reduce the number of falling letters
  var columns = c.width / font_size;

  var drops = [];
  for (var x = 0; x < columns; x++)
    drops[x] = 1;

  var intervalId;

  function drawMatrix() {
    // Dark grey background for the canvas to match the main page
    ctx.fillStyle = "rgba(51, 51, 51, 0.95)";
    ctx.fillRect(0, 0, c.width, c.height);

    ctx.fillStyle = "#0F0";
    ctx.font = font_size + "px arial";

    for (var i = 0; i < drops.length; i++) {
      var text = matrixChars[Math.floor(Math.random() * matrixChars.length)];
      ctx.fillText(text, i * font_size, drops[i] * font_size);

      if (drops[i] * font_size > c.height && Math.random() > 0.975)
        drops[i] = 0;

      drops[i]++;
    }
  }

  // Check if the starting page is visible
  if ($('#startPage').is(':visible')) {
    // Start the Matrix effect
    intervalId = setInterval(drawMatrix, 30);
  }
  
  // Stop the Matrix effect when the "Start" button is clicked
  $('#startButton').click(function() {
    clearInterval(intervalId);
    ctx.clearRect(0, 0, c.width, c.height);  // Clear the canvas
  });
});
