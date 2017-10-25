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
            try
            {
                return View(SetStatusAmountLeft());
            }
            catch (Exception)
            {
                throw;
            }
        }

        public ActionResult Dashboard()
        {
            IQueryable<Goal> goals = SetStatusAmountLeft();
            var accounts = db.Accounts.Where(g => g.Customer_ID == activeCustomer);

            List<string> accountNames = new List<string>();
            List<string> accountTotals = new List<string>();

            List<string> goalNames = new List<string>();
            List<string> goalAmtLeft = new List<string>();
            try
            {
                foreach (var account in accounts)
                {
                    account.Account_Total = db.Transactions.Where(t => t.Account_Number == account.Account_Number && t.Processing_Date <= testDate).Sum(item => item.Amount);
                    accountNames.Add("'" + account.Account_Type + "'"); //the labels in the chart can't be read without quotes
                    accountTotals.Add(account.Account_Total.ToString());
                }
                string AccountNamesList = string.Join(",", accountNames);
                string AccountTotalsList = string.Join(",", accountTotals);
                ViewBag.AccountNames_List = AccountNamesList;
                ViewBag.AccountTotals_List = AccountTotalsList;

                foreach (var goal in goals)
                {
                    if (goal.Status != "Future Test Goal")
                    {
                        goalNames.Add("'" + goal.Name + "'");
                        goalAmtLeft.Add(goal.Amount_Left.ToString());
                    }
                }
                string GoalNamesList = string.Join(",", goalNames);
                string GoalAmtLeftList = string.Join(",", goalAmtLeft);
                ViewBag.GoalNames_List = GoalNamesList;
                ViewBag.GoalAmtLeft_List = GoalAmtLeftList;
                return View();
            }
            catch (Exception)
            {
                throw;
            }
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
                goal.Start_Date = testDate;
                goal.Customer_ID = activeCustomer;
                db.Goals.Add(goal);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            CommonViewbag(goal);
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
            Session["Start_Date"] = goal.Start_Date;
            ViewBag.Account_Number = new SelectList(db.Accounts.Where(a => a.Customer_ID == activeCustomer), "Account_Number", "Account_Type", goal.Account_Number);
            ViewBag.Interval_Type = new SelectList(intervalType, goal.Interval_Type);
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
            DateTime thisDate = Convert.ToDateTime(System.Web.HttpContext.Current.Session["Start_Date"]);
            goal.Start_Date = thisDate;
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
        private IQueryable<Goal> SetStatusAmountLeft()
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
                    goal.Status = "Future Test Goal";
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
                decimal accountTotal = db.Transactions.Where(t => t.Account_Number == goal.Account_Number && t.Processing_Date <= testDate).Sum(item => item.Amount);
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
                        decimal accountTotalAtThisDate = db.Transactions.Where(t => t.Account_Number == goal.Account_Number && t.Processing_Date <= thisDate).Sum(item => item.Amount);
                        decimal savedTowardsGoalAmt = accountTotalAtThisDate - goal.Target_Amount;

                        DateTime prevDate = thisDate.AddDays(intervalAmount * -7);
                        if (savedTowardsGoalAmt <= 0)
                        {
                            goal.Goal_Achieved = "Failed Previous";
                        }
                        else
                        {
                            goal.Goal_Achieved = "Met Previous";
                        }
                        if (prevDate == goal.Start_Date)
                        {
                            goal.Goal_Achieved = "In Progress";

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
                        decimal accountTotalAtThisDate = db.Transactions.Where(t => t.Account_Number == goal.Account_Number && t.Processing_Date <= thisDate).Sum(item => item.Amount);
                        decimal goalMet = accountTotalAtThisDate - goal.Target_Amount;

                        DateTime prevDate = thisDate.AddMonths(-intervalAmount);
                        if (goalMet <= 0)
                        {
                            goal.Goal_Achieved = "Failed Previous";
                        }
                        else
                        {
                            goal.Goal_Achieved = "Met Previous";
                        }
                        if (prevDate == goal.Start_Date)
                        {
                            goal.Goal_Achieved = "In Progress";

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
                goal.Amount_Left = accountTotal - goal.Target_Amount;
                if (goal.Status == "Expired" && goal.Interval_Num == null && goal.Interval_Type == null)
                {
                    if (goal.Amount_Left <= 0)
                    {
                        goal.Goal_Achieved = "Failed Goal";
                    }
                    else
                    {
                        goal.Goal_Achieved = "Met Goal";
                    }
                }
                if (goal.Status == "Active" && goal.Interval_Num == null && goal.Interval_Type == null)
                {
                    goal.Goal_Achieved = "In Progress";
                }
            }

            return goals;


        }
    }
}
