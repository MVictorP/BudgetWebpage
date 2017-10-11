using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BudgetWebpage.Models;

namespace BudgetWebpage.Views
{
    public class GoalsController : Controller
    {
        private CapstoneDBEntities db = new CapstoneDBEntities();

        // GET: Goals
        public ActionResult Index()
        {
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            DateTime testDate = Convert.ToDateTime(Session["Test_Date"]);
            var goals = db.Goals.Where(g => g.Customer_ID == activeCustomer && g.Start_Date <= testDate);
            //var goals = db.Goals.Include(g => g.Account).Include(g => g.Customer);
            return View(goals.ToList());
        }

        public ActionResult Dashboard()
        {
            return View();
        }


        //// GET: Goals/Details/5
        //public ActionResult Details(int? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    Goal goal = db.Goals.Find(id);
        //    if (goal == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(goal);
        //}

        // GET: Goals/Create
        public ActionResult Create()
        {
            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type");
            //ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name");
            return View();
        }

        // POST: Goals/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Goal_ID,Customer_ID,Account_Number,Name,Description,Target_Amount,Start_Date,End_Date,Recurring_Status,Interval_Num,Interval_Type")] Goal goal)
        {
            if (ModelState.IsValid)
            {
                int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
                goal.Customer_ID = activeCustomer;
                db.Goals.Add(goal);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", goal.Account_Number);
            //ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name", goal.Customer_ID);
            return View(goal);
        }

        // GET: Goals/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Goal goal = db.Goals.Find(id);
            if (goal == null)
            {
                return HttpNotFound();
            }
            ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", goal.Account_Number);
            ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name", goal.Customer_ID);
            return View(goal);
        }

        // POST: Goals/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Goal_ID,Customer_ID,Account_Number,Name,Description,Target_Amount,Start_Date,End_Date,Recurring_Status,Interval_Num,Interval_Type")] Goal goal)
        {
            if (ModelState.IsValid)
            {
                db.Entry(goal).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", goal.Account_Number);
            ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name", goal.Customer_ID);
            return View(goal);
        }

        // GET: Goals/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Goal goal = db.Goals.Find(id);
            if (goal == null)
            {
                return HttpNotFound();
            }
            return View(goal);
        }

        // POST: Goals/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Goal goal = db.Goals.Find(id);
            db.Goals.Remove(goal);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
