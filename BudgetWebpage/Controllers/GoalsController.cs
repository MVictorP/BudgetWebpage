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
            var goals = db.Goals.Where(g => g.Customer_ID == activeCustomer);
            foreach (var oParam in goals)
            {
                if (oParam.Start_Date < testDate && oParam.End_Date > testDate)
                {
                    oParam.Status = "Active";
                }
                if (oParam.Start_Date > testDate)
                {
                    oParam.Status = "Upcoming";
                }
                if (oParam.End_Date != null && oParam.End_Date < testDate)
                {
                    oParam.Status = "Expired";
                }
                if (oParam.Start_Date < testDate && oParam.End_Date == testDate)
                {
                    oParam.Status = "Ending Today";
                }
                if (oParam.Start_Date == testDate )
                {
                    oParam.Status = "Created Today";
                }

            }
            //var goals = db.Goals.Include(g => g.Account).Include(g => g.Customer);
            return View(goals.ToList());
        }

        public ActionResult Dashboard()
        {
            return View();
        }

        // GET: Goals/Details/5
        public ActionResult Details(int? id)
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

        // GET: Goals/Create
        public ActionResult Create()
        {
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            var selectedInterval = new List<string> { "Months", "Weeks" };
            var intervalNumRange = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };

            ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type");
            ViewBag.Interval_Type = new SelectList(selectedInterval);
            ViewBag.Interval_Num = new SelectList(intervalNumRange);

            return View();
        }

        // POST: Goals/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Goal_ID,Customer_ID,Account_Number,Name,Description,Target_Amount,Start_Date,End_Date,Recurring_Status,Interval_Num,Interval_Type")] Goal goal)
        {
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            var selectedInterval = new List<string> { "Months", "Weeks" };
            var intervalNumRange = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };

            if (goal.Start_Date >= goal.End_Date)
            {
                ModelState.AddModelError("End_Date", "End Date must after the Start Date");

                ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type", goal.Account_Number);
                ViewBag.Interval_Type = new SelectList(selectedInterval);
                ViewBag.Interval_Num = new SelectList(intervalNumRange);

                return View(goal);
            }

            if (ModelState.IsValid)
            {
                if (goal.Recurring_Status == false)
                {
                    goal.Interval_Num = null;
                    goal.Interval_Type = null;
                }
                goal.Customer_ID = activeCustomer;
                db.Goals.Add(goal);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type", goal.Account_Number);
            ViewBag.Interval_Type = new SelectList(selectedInterval);
            ViewBag.Interval_Num = new SelectList(intervalNumRange);

            return View(goal);
        }

        // GET: Goals/Edit/5
        public ActionResult Edit(int? id)
        {
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            var selectedInterval = new List<string> { "Months", "Weeks" };
            var intervalNumRange = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Goal goal = db.Goals.Find(id);
            Session["Start_Date"] = goal.Start_Date;
            if (goal == null)
            {
                return HttpNotFound();
            }
            ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type", goal.Account_Number);
            ViewBag.Interval_Type = new SelectList(selectedInterval, goal.Interval_Type);
            ViewBag.Interval_Num = new SelectList(intervalNumRange, goal.Interval_Num);
            return View(goal);
        }

        // POST: Goals/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Goal_ID,Customer_ID,Account_Number,Name,Description,Target_Amount,Start_Date,End_Date,Recurring_Status,Interval_Num,Interval_Type")] Goal goal)
        {
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            var selectedInterval = new List<string> { "Months", "Weeks" };
            var intervalNumRange = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };

            if (goal.Start_Date >= goal.End_Date)
            {
                ModelState.AddModelError("End_Date", "End Date must after the Start Date");

                ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type", goal.Account_Number);
                ViewBag.Interval_Type = new SelectList(selectedInterval);
                ViewBag.Interval_Num = new SelectList(intervalNumRange);

                return View(goal);
            }

            if (ModelState.IsValid)
            {
                if (goal.Recurring_Status == false)
                {
                    goal.Interval_Num = null;
                    goal.Interval_Type = null;
                }
                goal.Customer_ID = activeCustomer;
                db.Entry(goal).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type", goal.Account_Number);
            ViewBag.Interval_Type = new SelectList(selectedInterval);
            ViewBag.Interval_Num = new SelectList(intervalNumRange);
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
