const slugify = require("slugify");

function SlugMake(title) {
  return slugify(title, {
    replacement: "-",
    remove: /[*+~.()'"!:@]/g,
    lower: true,
    locale: ["en", "bn"],
  });
}

module.exports = { SlugMake };
