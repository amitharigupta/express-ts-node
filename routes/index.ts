import express, { Request, Response, NextFunction } from 'express';
import usersRouter from "./users";
import instrumentRoutes from "./instrument.routes";

const router = express.Router();

/* GET home page. */
router.get('/', function(req: Request, res: Response, next: NextFunction) {
  res.render('index', { title: 'Express' });
});

// User Routes
router.use("/users", usersRouter);

// instrument routes
router.use('/instruments', instrumentRoutes);

export default router;
