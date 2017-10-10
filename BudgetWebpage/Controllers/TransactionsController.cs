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
    public class TransactionsController : Controller
    {
        private CapstoneDBEntities db = new CapstoneDBEntities();

        // GET: Transactions
        public ActionResult Index()
        {
            string selectedAccount = Convert.ToString(Session["Account_Number"]);
            DateTime testDate = Convert.ToDateTime(Session["Test_Date"]);
            var transactions = db.Transactions.Where(t => t.Account_Number == selectedAccount && t.Processing_Date <= testDate);
            return View(transactions.ToList());
        }

        // GET: Transactions/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Transaction transaction = db.Transactions.Find(id);
            if (transaction == null)
            {
                return HttpNotFound();
            }
            return View(transaction);
        }

        // GET: Transactions/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Transaction transaction = db.Transactions.Find(id);
            if (transaction == null)
            {
                return HttpNotFound();
            }
            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", transaction.Account_Number);
            return View(transaction);
        }

        // POST: Transactions/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Transaction_ID,Account_Type,Account_Number,Processing_Date,Transaction_Type,Amount,Description,Category")] Transaction transaction)
        {
            if (ModelState.IsValid)
            {
                db.Entry(transaction).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            //ViewBag.Account_Number = new SelectList(db.Accounts, "Account_Number", "Account_Type", transaction.Account_Number);
            return View(transaction);
        }
    }
}
