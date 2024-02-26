const category = require("../services/category/categoryServices");
const { formidable } = require("formidable");

class categoryController {
  get_all_categories = async (req, res, next) => {
    try {
      const result = await category.get_all_categories();
      res.status(200).json({ status: 200, data: result });
    } catch (error) {
      next(error);
    }
  };
  add_category = async (req, res, next) => {
    try {
      const formData = formidable({});
      const [fields, files] = await formData.parse(req);
      if (!fields.categoryName || !files.categoryLogo) {
        return res
          .status(400)
          .json({ status: "fail", message: "Invalid input" });
      }
      const categoryName = fields.categoryName;
      const categoryLogo = files.categoryLogo;
      const result = await category.add_category({
        categoryName: categoryName[0],
        categoryLogo: categoryLogo[0],
      });
      res.status(201).json({ status: "success", data: result });
    } catch (error) {
      next(error);
    }
  };
}

module.exports = new categoryController();
