const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const error = require("../../../utlis/error");
const { cloudinary } = require("../../../utlis/cloudinary");
const { SlugMake } = require("../../../utlis/Slugify");

//get all brands
async function findBrands() {
  return prisma.brands.findMany();
}

//single brand get

async function findSingleBrand(id) {
  return prisma.brands.findUnique({
    where: {
      id: parseInt(id),
    },
  });
}

//add brand
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

//update brand
async function update_brand({ id, brandName, brandLogo }) {
  const brand = await prisma.brands.findUnique({
    where: {
      id: parseInt(id),
    },
  });
  if (!brand) throw error("Brand not found", 404);

  const { url } = await cloudinary.uploader.upload(brandLogo[0].filepath, {
    folder: "ecom/brand_image",
    use_filename: true,
    unique_filename: false,
    overwrite: true,
    transformation: [{ width: 500, height: 500, crop: "limit" }],
    format: "webp",
  });

  //delete the previous image
  cloudinary.api
    .delete_resources(
      ["ecom/brand_image/" + brand.brandLogo.split("/").pop().split(".")[0]],
      {
        type: "upload",
        resource_type: "image",
      }
    )
    .then(console.log);

  return prisma.brands.update({
    where: {
      id: parseInt(id),
    },
    data: {
      brandName: brandName ? brandName : brand.brandName,
      slug: SlugMake(brandName) ? SlugMake(brandName) : brand.slug,
      brandLogo: url ? url : brand.brandLogo,
    },
  });
}

async function delete_brand(id) {
  // brands has products so we cannot delete it directly

  const products = await prisma.products.findMany({
    where: {
      brandId: parseInt(id),
    },
  });

  if (products.length > 0)
    throw error("Brand has products. don't Try Delete", 400);
  const brand = await prisma.brands.findUnique({
    where: {
      id: parseInt(id),
    },
  });
  if (!brand) throw error("Brand not found", 404);
  //delete the image from cloudinary
  cloudinary.api
    .delete_resources(
      ["ecom/brand_image/" + brand.brandLogo.split("/").pop().split(".")[0]],
      {
        type: "upload",
        resource_type: "image",
      }
    )
    .then(console.log);
  return prisma.brands.delete({
    where: {
      id: parseInt(id),
    },
  });
}

module.exports = {
  findBrands,
  findSingleBrand,
  add_brand,
  update_brand,
  delete_brand,
};
