// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


import Rails from "@rails/ujs"
Rails.start()

document.addEventListener("DOMContentLoaded", () => {
  const flashMessages = document.querySelectorAll(".flash-message");
  flashMessages.forEach((message) => {
    setTimeout(() => {
      message.style.opacity = "0";
      setTimeout(() => message.remove(), 500); // Wait for fade-out to finish
    }, 3000); // Hide after 3 seconds
  });
});