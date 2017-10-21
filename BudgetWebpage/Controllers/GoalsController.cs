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
        private List<int> intervalNumRange = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };
        private List<string> intervalType = new List<string> { "Months", "Weeks" };
        private DateTime testDate = Convert.ToDateTime(System.Web.HttpContext.Current.Session["Test_Date"]);
        private int activeCustomer = Convert.ToInt32(System.Web.HttpContext.Current.Session["Customer_ID"]);

        // GET: Goals
        public ActionResult Index()
        {
            var goals = db.Goals.Where(g => g.Customer_ID == activeCustomer);
            foreach (var goal in goals)
            {
                if (goal.Start_Date < testDate && testDate < goal.End_Date)
                {
                    goal.Status = "Active";
                }
                if (goal.Start_Date < testDate && goal.End_Date == null)
                {
                    goal.Status = "Active";
                }
                if (testDate < goal.Start_Date)
                {
                    goal.Status = "Upcoming";
                }
                if (goal.End_Date < testDate)
                {
                    goal.Status = "Expired";
                }
                if (goal.End_Date == testDate)
                {
                    goal.Status = "Ending Today";
                }
                if (goal.Start_Date == testDate)
                {
                    goal.Status = "Created Today";
                }

                if (goal.Recurring_Status == true)
                {
                    int intervalAmount = Convert.ToInt32(goal.Interval_Num);
                    if (goal.Interval_Type == "Weeks")
                    {
                        goal.Interval_Period_End_Date = goal.Start_Date.AddDays(intervalAmount * 7);
                        DateTime thisDate = goal.Start_Date.AddDays(intervalAmount * 7);
                        while (thisDate < testDate)
                        {
                            thisDate = thisDate.AddDays(intervalAmount * 7);
                            goal.Interval_Period_End_Date = thisDate;
                        }
                    }
                    if (goal.Interval_Type == "Months")
                    {
                        goal.Interval_Period_End_Date = goal.Start_Date.AddMonths(intervalAmount);
                        DateTime thisDate = goal.Start_Date.AddMonths(intervalAmount);
                        while (thisDate < testDate)
                        {
                            thisDate = thisDate.AddMonths(intervalAmount);
                            goal.Interval_Period_End_Date = thisDate;
                        }
                    }
                    if (goal.Interval_Period_End_Date > goal.End_Date)
                    {
                        goal.Interval_Period_End_Date = null;
                    }
                }
                else
                {
                    goal.Interval_Period_End_Date = null;
                }

            }
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
            ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type");
            ViewBag.Interval_Type = new SelectList(intervalType);
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
            if (goal.Start_Date >= goal.End_Date)
            {
                ModelState.AddModelError("End_Date", "End Date must after the Start Date");

                CommonViewbag(goal);
                return View(goal);
            }
            if (goal.Recurring_Status == true)
            {
                int interval = Convert.ToInt32(goal.Interval_Num);
                if (goal.Interval_Type == "Weeks")
                {
                    goal.Interval_Period_End_Date = goal.Start_Date.AddDays(interval * 7);
                }
                if (goal.Interval_Type == "Months")
                {
                    goal.Interval_Period_End_Date = goal.Start_Date.AddMonths(interval);
                }
            }
            if (goal.End_Date < goal.Interval_Period_End_Date)
            {
                ModelState.AddModelError("End_Date", "The End Date must be after the first reoccurance");
                CommonViewbag(goal);
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

            CommonViewbag(goal);
            return View(goal);
        }

        // GET: Goals/Edit/5
        public ActionResult Edit(int? id )
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
            //Session["Start_Date"] = goal.Start_Date;
            CommonViewbag(goal);
            return View(goal);
        }

        // POST: Goals/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Goal_ID,Customer_ID,Account_Number,Name,Description,Target_Amount,Start_Date,End_Date,Recurring_Status,Interval_Num,Interval_Type")] Goal goal)
        {
            if (goal.Start_Date >= goal.End_Date)
            {
                ModelState.AddModelError("End_Date", "End Date must after the Start Date");
                CommonViewbag(goal);      
                return View(goal);
            }
            if (goal.Recurring_Status == true)
            {
                int interval = Convert.ToInt32(goal.Interval_Num);
                if (goal.Interval_Type == "Weeks")
                {
                    goal.Interval_Period_End_Date = goal.Start_Date.AddDays(interval * 7);
                }
                if (goal.Interval_Type == "Months")
                {
                    goal.Interval_Period_End_Date = goal.Start_Date.AddMonths(interval);
                }
            }
            if (goal.End_Date < goal.Interval_Period_End_Date)
            {
                ModelState.AddModelError("End_Date", "The End Date must be after the first reoccurance");
                CommonViewbag(goal);
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
            CommonViewbag(goal);
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

        //occurs in multiple views
        private void CommonViewbag(Goal goal)
        {
            ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type", goal.Account_Number);
            ViewBag.Interval_Type = new SelectList(intervalType);
            ViewBag.Interval_Num = new SelectList(intervalNumRange);
        }
    }
}
