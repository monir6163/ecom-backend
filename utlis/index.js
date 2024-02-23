const { Router } = require("express");
const router = Router();
const brandRoutes = require("../routes/brandRoutes");
// const categoryRoutes = require("../routes/categoryRoutes");

const moduleRoutes = [
  {
    path: "/brands",
    route: brandRoutes,
  },
  // {
  //   path: "/categories",
  //   route: categoryRoutes,
  // },
];

moduleRoutes.forEach((route) => router.use(route.path, route.route));

module.exports = router;
