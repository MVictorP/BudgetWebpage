using BudgetWebpage.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BudgetWebpage.Controllers
{
    public class HomeController : Controller
    {
        private CapstoneDBEntities db = new CapstoneDBEntities();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "UMKC School of Computing and Engineering";

            return View();
        }
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Models.LoginModel login)
        {

            if (ModelState.IsValid)
            {
                var user = (from userlist in db.Customers where userlist.Username == login.Username && userlist.Password == login.Password select new { userlist.Customer_ID }).ToList();
                if (user.FirstOrDefault() != null)
                {
                    Session["Customer_ID"] = user.FirstOrDefault().Customer_ID;
                    Session["Test_Date"] = login.Test_Date;
                    return Redirect("/Budgets/Index");
                }
                else
                {
                    ModelState.AddModelError("", "Invalid Login Credentials");
                }
            }
            return View(login);
        }
    }
}