const categoryController = require("../controllers/category/categoryController");

const router = require("express").Router();

router.get("/", categoryController.get_all_categories);
router.post("/", categoryController.add_category);

module.exports = router;
