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
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            var accounts = db.Accounts.Where(a => a.Customer_ID == activeCustomer);
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
