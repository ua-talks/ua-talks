import "index.css"

// Import all JavaScript & CSS files from src/_components
import components from "bridgetownComponents/**/*.{js,jsx,js.rb,css}"
import Turbolinks from "turbolinks"

Turbolinks.start()
console.info("Bridgetown is loaded!")
