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

  //get a single brand
  get_single_brand = async (req, res, next) => {
    try {
      const { id } = req.params;
      const result = await brands.findSingleBrand(id);
      res.status(200).json({ status: "success", data: result });
    } catch (error) {
      next(error);
    }
  };

  //add a brand

  add_brand = async (req, res, next) => {
    try {
      const formData = formidable({});
      const [fields, files] = await formData.parse(req);
      if (!fields.brandName || !files.brandLogo) {
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

  //update a brand
  update_brand = async (req, res, next) => {
    try {
      const { id } = req.params;
      const formData = formidable({});
      const [fields, files] = await formData.parse(req);

      const brandName = fields.brandName;
      const brandLogo = files.brandLogo;
      const result = await brands.update_brand({
        id: id,
        brandName: brandName[0],
        brandLogo: brandLogo,
      });
      res.status(200).json({ status: "success", data: result });
    } catch (error) {
      next(error);
    }
  };

  //delete a brand
  delete_brand = async (req, res, next) => {
    try {
      const { id } = req.params;
      const result = await brands.delete_brand(id);
      res.status(200).json({ status: "success", data: result });
    } catch (error) {
      next(error);
    }
  };
}

module.exports = new brandController();
