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

// for image carousel
document.addEventListener("turbo:load", () => {
  const slides = document.querySelectorAll(".slide");
  if (slides.length === 0) return;

  let currentSlide = 0;

  const showSlide = (index) => {
    slides.forEach((slide, i) => {
      slide.classList.remove("active", "prev");
      if (i === index) {
        slide.classList.add("active");
      } else if (i === (index - 1 + slides.length) % slides.length) {
        slide.classList.add("prev");
      }
    });
  };

  const nextSlide = () => {
    currentSlide = (currentSlide + 1) % slides.length;
    showSlide(currentSlide);
  };

  showSlide(currentSlide); // Initialize first slide
  setInterval(nextSlide, 4000); // Advance every 4 seconds
});