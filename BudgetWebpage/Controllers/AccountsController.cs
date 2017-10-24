using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace BudgetWebpage.Models
{
    public class AccountsController : Controller
    {
        private CapstoneDBEntities db = new CapstoneDBEntities();

        // GET: Accounts
        public ActionResult Index() //Showing accounts for logged in user
        {
            decimal allAccountsSum = 0;
            DateTime testDate = Convert.ToDateTime(Session["Test_Date"]);
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            var accounts = db.Accounts.Where(a => a.Customer_ID == activeCustomer);           
            foreach (var account in accounts)
            {
                account.Account_Total = db.Transactions.Where(t => t.Account_Number == account.Account_Number && t.Processing_Date <= testDate).Sum(item => item.Amount);
                if (account.Account_Type == "Checking")
                {
                    allAccountsSum += account.Account_Total;
                }
                if (account.Account_Type == "Savings")
                {
                    allAccountsSum += account.Account_Total;
                }
                if (account.Account_Type == "Credit Card")
                {
                    allAccountsSum -= account.Account_Total; //credit is debt so subtract from overall total
                }
            }
            Session["Customer_Balance"] = Math.Round(allAccountsSum, 2);  
            return View(accounts.ToList());
        }

        // GET: Accounts/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Account account = db.Accounts.Find(id);
            Session["Account_Number"] = account.Account_Number;
            return Redirect("/Transactions/Index");
        }      
    }
}
