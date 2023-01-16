import express, { Request, Response } from "express"

const app = express()

app.get("/", (req: Request, res: Response) => {
    return res.json({
        status: "Success!!!",
    });
});

const port = 5000

app.listen(port, () => console.log(`Listening on ${port}`));