import express from "express";
import {Request, Response, Router} from "express";
import { AccountsManager } from "./accounts/accounts";
import { FinancialManager } from "./financial/financial";
import { EventsManager } from "./events/events";
import cors from "cors";

const port = 3000; 
const routes = Router();
var app = express();
app.use(cors());

app.use(routes);
routes.get('/', (req: Request, res: Response)=>{
    res.statusCode = 403;
    res.send('Acesso não permitido. Rota default não definida.');
});


routes.post('/signUp', AccountsManager.signUpHandler);
routes.post('/login',AccountsManager.loginHandler);
routes.post('/addNewEvent', EventsManager.createEventHandler);
routes.post('/getEvents', EventsManager.getEventHandler);
routes.post('/deleteEvent', EventsManager.deleteEventHandler);
routes.post('/evaluateNewEvent', EventsManager.evaluateNewEventHandler);
routes.post('/addFunds', FinancialManager.addFundsHandler);
routes.post('/withdrawFunds', FinancialManager.withdrawFundsHandler);
routes.post('/betOnEvent', EventsManager.betOnEventHandler);
routes.post('/finishEvent', EventsManager.finishEventHandler);
routes.post('/searchEvent', EventsManager.searchEventHandler);
routes.post('/wallet', FinancialManager.walletHandler);
routes.post('/home', EventsManager.homeHandler);
routes.post('/signOut', AccountsManager.signOutHandler);


app.listen(port, ()=>{
    console.log(`Server is running on: ${port}`);
})