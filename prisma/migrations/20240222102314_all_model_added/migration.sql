-- CreateEnum
CREATE TYPE "Products_remark" AS ENUM ('POPULAR', 'NEW', 'TOP', 'SPECIAL', 'TRENDING', 'REGULAR');

-- CreateEnum
CREATE TYPE "delivery_status" AS ENUM ('PENDING', 'COMPLETED', 'PROCESSING');

-- CreateEnum
CREATE TYPE "policies_type" AS ENUM ('PRIVACY', 'TERMS', 'SHIPPING', 'REFUND', 'PAYMENT', 'ABOUT', 'CONTACT', 'FAQ', 'BLOG');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateTable
CREATE TABLE "Brands" (
    "id" SERIAL NOT NULL,
    "brandName" VARCHAR(255) NOT NULL,
    "slug" VARCHAR(255) NOT NULL,
    "brandLogo" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Brands_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Categories" (
    "id" SERIAL NOT NULL,
    "categoryName" VARCHAR(255) NOT NULL,
    "slug" VARCHAR(255) NOT NULL,
    "categoryLogo" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "slug" VARCHAR(255) NOT NULL,
    "productImage" VARCHAR(255) NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "discount" BOOLEAN NOT NULL DEFAULT false,
    "discountPrice" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "stock" BOOLEAN NOT NULL DEFAULT true,
    "star" DOUBLE PRECISION NOT NULL,
    "shortdes" VARCHAR(500) NOT NULL,
    "remark" "Products_remark" NOT NULL,
    "brandId" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product_details" (
    "id" SERIAL NOT NULL,
    "image" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "color" VARCHAR(255) NOT NULL,
    "size" VARCHAR(255) NOT NULL,
    "productId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Product_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product_slider" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "slug" VARCHAR(255) NOT NULL,
    "shortdes" VARCHAR(500) NOT NULL,
    "image" VARCHAR(255) NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "productId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Product_slider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "otp" VARCHAR(255) NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Customers_profile" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "state" VARCHAR(255) NOT NULL,
    "country" VARCHAR(255) NOT NULL,
    "zip" VARCHAR(255) NOT NULL,
    "ship_name" VARCHAR(255) NOT NULL,
    "ship_phone" VARCHAR(255) NOT NULL,
    "ship_city" VARCHAR(255) NOT NULL,
    "ship_state" VARCHAR(255) NOT NULL,
    "ship_country" VARCHAR(255) NOT NULL,
    "ship_zip" VARCHAR(255) NOT NULL,
    "ship_address" VARCHAR(255) NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Customers_profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products_cart" (
    "id" SERIAL NOT NULL,
    "qty" DOUBLE PRECISION NOT NULL,
    "color" VARCHAR(255) NOT NULL,
    "size" VARCHAR(255) NOT NULL,
    "productId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Products_cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products_wishlist" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Products_wishlist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products_review" (
    "id" SERIAL NOT NULL,
    "review" TEXT NOT NULL,
    "star" DOUBLE PRECISION NOT NULL,
    "productId" INTEGER NOT NULL,
    "customerId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Products_review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invoice" (
    "id" SERIAL NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "vat" DOUBLE PRECISION NOT NULL,
    "payable" DOUBLE PRECISION NOT NULL,
    "cus_details" VARCHAR(500) NOT NULL,
    "ship_details" VARCHAR(500) NOT NULL,
    "tran_id" VARCHAR(255) NOT NULL,
    "val_id" VARCHAR(255) NOT NULL DEFAULT '0',
    "delivery_status" "delivery_status" NOT NULL,
    "payment_status" VARCHAR(255) NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Invoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invoice_products" (
    "id" SERIAL NOT NULL,
    "qty" DOUBLE PRECISION NOT NULL,
    "salePrice" DOUBLE PRECISION NOT NULL,
    "color" VARCHAR(255) NOT NULL,
    "size" VARCHAR(255) NOT NULL,
    "productId" INTEGER NOT NULL,
    "invoiceId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Invoice_products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Policies" (
    "id" SERIAL NOT NULL,
    "type" "policies_type" NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Policies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sslcommerz_payment" (
    "id" SERIAL NOT NULL,
    "store_id" VARCHAR(255) NOT NULL,
    "store_passwd" VARCHAR(255) NOT NULL,
    "currency" VARCHAR(255) NOT NULL,
    "success_url" VARCHAR(255) NOT NULL,
    "fail_url" VARCHAR(255) NOT NULL,
    "cancel_url" VARCHAR(255) NOT NULL,
    "ipn_url" VARCHAR(255) NOT NULL,
    "initial_url" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Sslcommerz_payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Features" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "content" TEXT NOT NULL,
    "image" VARCHAR(500) NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Features_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Brands_brandName_key" ON "Brands"("brandName");

-- CreateIndex
CREATE UNIQUE INDEX "Brands_slug_key" ON "Brands"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Categories_categoryName_key" ON "Categories"("categoryName");

-- CreateIndex
CREATE UNIQUE INDEX "Categories_slug_key" ON "Categories"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Products_title_key" ON "Products"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Products_slug_key" ON "Products"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Product_details_productId_key" ON "Product_details"("productId");

-- CreateIndex
CREATE UNIQUE INDEX "Product_slider_title_key" ON "Product_slider"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Product_slider_slug_key" ON "Product_slider"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Product_slider_productId_key" ON "Product_slider"("productId");

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Customers_profile_phone_key" ON "Customers_profile"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "Customers_profile_userId_key" ON "Customers_profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Policies_type_key" ON "Policies"("type");

-- CreateIndex
CREATE UNIQUE INDEX "Policies_title_key" ON "Policies"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Features_title_key" ON "Features"("title");

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "Brands"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Categories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product_details" ADD CONSTRAINT "Product_details_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product_slider" ADD CONSTRAINT "Product_slider_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customers_profile" ADD CONSTRAINT "Customers_profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products_cart" ADD CONSTRAINT "Products_cart_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products_cart" ADD CONSTRAINT "Products_cart_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products_wishlist" ADD CONSTRAINT "Products_wishlist_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products_wishlist" ADD CONSTRAINT "Products_wishlist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products_review" ADD CONSTRAINT "Products_review_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products_review" ADD CONSTRAINT "Products_review_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "Customers_profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice_products" ADD CONSTRAINT "Invoice_products_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice_products" ADD CONSTRAINT "Invoice_products_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice_products" ADD CONSTRAINT "Invoice_products_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
