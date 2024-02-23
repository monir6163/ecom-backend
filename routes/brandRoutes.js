const brandController = require("../controllers/brand/brandController");

const router = require("express").Router();

router.post("/", brandController.add_brand);
router.get("/", brandController.get_brand);
// router.get("/:id", brandController.get_brand);
// router.put("/:id", brandController.update_brand);
// router.delete("/:id", brandController.delete_brand);

module.exports = router;
