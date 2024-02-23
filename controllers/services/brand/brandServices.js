const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const error = require("../../../utlis/error");
const { cloudinary } = require("../../../utlis/cloudinary");
const { SlugMake } = require("../../../utlis/Slugify");

async function findBrands() {
  return prisma.brands.findMany();
}

async function add_brand({ brandName, brandLogo }) {
  //check if brand already exists
  const brand = await prisma.brands.findFirst({
    where: {
      brandName: brandName,
    },
  });
  if (brand) throw error("Brand already exist", 400);
  const { url } = await cloudinary.uploader.upload(brandLogo.filepath, {
    folder: "ecom/brand_image",
    use_filename: true,
    unique_filename: false,
    overwrite: true,
    transformation: [{ width: 500, height: 500, crop: "limit" }],
    format: "webp",
  });
  return prisma.brands.create({
    data: {
      brandName,
      slug: SlugMake(brandName),
      brandLogo: url,
    },
  });
}

module.exports = {
  findBrands,
  add_brand,
};
