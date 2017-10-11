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
        //Used this as a guide:
        //http://www.dotnetlearners.com/blogs/view/124/Login-Page-Example-In-MVC-Using-Entity-Frame-Work.aspx
        {
            if (ModelState.IsValid)
            {
                CapstoneDBEntities db = new CapstoneDBEntities();
                try
                {
                    var user = (from userlist in db.Customers where userlist.Username == login.Username && userlist.Password == login.Password select new { userlist.Customer_ID }).ToList();
                    if (user.FirstOrDefault() != null)
                    {
                        Session["Customer_ID"] = user.FirstOrDefault().Customer_ID;
                        Session["Test_Date"] = login.Test_Date;
                        return Redirect("/Goals/Dashboard");
                    }
                    ModelState.AddModelError("", "Invalid Login Credentials");
                    return View(login);
                }
                catch (Exception e)
                {
                    ModelState.AddModelError("", e.Message);
                    return View(login);
                }
            }
            else
            {
                ModelState.AddModelError("", "Invalid Model State");
                return View(login);
            }
        }
    }
}