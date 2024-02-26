const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const error = require("../../../utlis/error");
const { cloudinary } = require("../../../utlis/cloudinary");
const { SlugMake } = require("../../../utlis/Slugify");

class categoryServices {
  get_all_categories = async () => {
    return prisma.categories.findMany();
  };

  add_category = async ({ categoryName, categoryLogo }) => {
    //check if category already exists
    const category = await prisma.categories.findFirst({
      where: {
        categoryName: categoryName,
      },
    });
    if (category) throw error("Category already exist", 400);
    const { url } = await cloudinary.uploader.upload(categoryLogo.filepath, {
      folder: "ecom/cat_image",
      use_filename: true,
      unique_filename: false,
      overwrite: true,
      transformation: [{ width: 500, height: 500, crop: "limit" }],
      format: "webp",
    });
    return prisma.categories.create({
      data: {
        categoryName,
        slug: SlugMake(categoryName),
        categoryLogo: url,
      },
    });
  };
}

module.exports = new categoryServices();
