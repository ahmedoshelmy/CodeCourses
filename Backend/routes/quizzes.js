const express = require("express");
const router = express.Router();
const quizController = require("../controllers/quizController");
const { authToken } = require("../middleware/auth");
const multer = require("multer");
const upload = multer({ dest: "images/" });
const { canCreateCourse } = require("../permissions/coursePermissions");

router.get("/", quizController.getAllQuizzes);
router.get("/getquizbyid/:q_id", quizController.getQuizById);
router.get("/getByInstructor/:i_id", quizController.getQuizzesByInstructor);
router.get("/getByStudent/:s_id", quizController.getQuizzesByStudent);
router.post("/create", [authToken, canCreateCourse], upload.single('image'), quizController.postQuiz);
router.post("/take/:q_id", [authToken], quizController.takeQuiz);

router.post;

module.exports = router;
