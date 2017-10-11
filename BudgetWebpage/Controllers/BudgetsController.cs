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
    public class BudgetsController : Controller
    {
        private CapstoneDBEntities db = new CapstoneDBEntities();

        // GET: Budgets
        public ActionResult Index()
        {
            int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
            DateTime testDate = Convert.ToDateTime(Session["Test_Date"]);
            var budgets = db.Budgets.Where(b => b.Customer_ID == activeCustomer && b.Start_Date <= testDate);
            //var budgets = db.Budgets.Include(b => b.Account).Include(b => b.Customer);
            return View(budgets.ToList());
        }

        // GET: Budgets/Create
        public ActionResult Create()
        {
            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type");
            //ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name");
            return View();
        }

        // POST: Budgets/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Budget_ID,Customer_ID,Budget_Name,Budget_Amount,Budget_Category,Month_Interval,Start_Date")] Budget budget)
        {
            if (ModelState.IsValid)
            {
                int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
                budget.Customer_ID = activeCustomer;
                db.Budgets.Add(budget);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", budget.Account_Number);
            //ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name", budget.Customer_ID);
            return View(budget);
        }

        // GET: Budgets/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Budget budget = db.Budgets.Find(id);
            if (budget == null)
            {
                return HttpNotFound();
            }
            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", budget.Account_Number);
            //ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name", budget.Customer_ID);
            return View(budget);
        }

        // POST: Budgets/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Budget_ID,Customer_ID,Budget_Name,Budget_Amount,Budget_Category,Month_Interval,Start_Date")] Budget budget)
        {
            if (ModelState.IsValid)
            {
                int activeCustomer = Convert.ToInt32(Session["Customer_ID"]);
                budget.Customer_ID = activeCustomer;
                db.Entry(budget).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", budget.Account_Number);
            //ViewBag.Customer_ID = new SelectList(db.Customers, "Customer_ID", "First_Name", budget.Customer_ID);
            return View(budget);
        }

        // GET: Budgets/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Budget budget = db.Budgets.Find(id);
            if (budget == null)
            {
                return HttpNotFound();
            }
            return View(budget);
        }

        // POST: Budgets/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Budget budget = db.Budgets.Find(id);
            db.Budgets.Remove(budget);
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
