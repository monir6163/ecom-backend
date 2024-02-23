const { formidable } = require("formidable");

async function category_add(req, res) {
  try {
    const formData = formidable({});
    const [fields, files] = await formData.parse(req);
    const categoryName = fields.categoryName[0].trim();
    const categoryIcon = files.categoryIcon[0].filepath;
    return { categoryName, categoryIcon };
  } catch (error) {
    return error;
  }
}

module.exports = {
  category_add,
};
