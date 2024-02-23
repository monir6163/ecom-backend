const { formidable } = require("formidable");
const brands = require("../services/brand/brandServices");

class brandController {
  get_brand = async (req, res, next) => {
    try {
      const result = await brands.findBrands();
      res.status(200).json({ status: "success", data: result });
    } catch (error) {
      next(error);
    }
  };

  add_brand = async (req, res, next) => {
    try {
      const formData = formidable({});
      const [fields, files] = await formData.parse(req);
      if (!fields.brandName[0] || !files.brandLogo[0]) {
        return res
          .status(400)
          .json({ status: "fail", message: "Invalid input" });
      }
      const brandName = fields.brandName;
      const brandLogo = files.brandLogo;
      const result = await brands.add_brand({
        brandName: brandName[0],
        brandLogo: brandLogo[0],
      });
      res.status(201).json({ status: "success", data: result });
    } catch (error) {
      next(error);
    }
  };
}

module.exports = new brandController();
