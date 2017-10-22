using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace BudgetWebpage.Models
{
    public class AccountMetadata
    {
        public string Account_Number { get; set; }
        public int Customer_ID { get; set; }
        [Display(Name = "Account Type")]
        public string Account_Type { get; set; }
    }

    public partial class Account
    {
        [Display(Name = "Balance")]
        public decimal Account_Total { get; set; }
    }

    public class BudgetMetadata
    {
        public int Budget_ID { get; set; }
        public Nullable<int> Customer_ID { get; set; }

        [Required(ErrorMessage = "Please enter a name.")]
        [Display(Name = "Budget Name")]
        public string Budget_Name { get; set; }

        [Required(ErrorMessage = "Please enter an amount.")]
        [Display(Name = "Budget Amount")]
        public Nullable<decimal> Budget_Amount { get; set; }

        [Required(ErrorMessage = "Please enter a category.")]
        [Display(Name = "Budget Category")]
        public string Budget_Category { get; set; }

        [Required(ErrorMessage = "Please enter an interval.")]
        [Display(Name = "Month Interval")]
        public Nullable<int> Month_Interval { get; set; }

        [Required(ErrorMessage = "Please enter a date.")]
        [Display(Name = "Start Date")]
        [DataType(DataType.Date)]
        public Nullable<System.DateTime> Start_Date { get; set; }
    }

    public class CustomerMetadata
    {
        [Display(Name = "Transaction ID")]
        public int Customer_ID { get; set; }
        [Display(Name = "First Name")]
        public string First_Name { get; set; }
        [Display(Name = "Last Name")]
        public string Last_Name { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public partial class Customer
    {

    }

    public class GoalMetadata
    {
        public int Goal_ID { get; set; }

        public int Customer_ID { get; set; }

        [Required(ErrorMessage = "Please select an account.")]
        public string Account_Number { get; set; }

        [Required(ErrorMessage = "Please enter a name.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Please enter a name.")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Please enter an amount.")]
        [Display(Name = "Goal Amount")]
        public decimal Target_Amount { get; set; }

        [Required(ErrorMessage = "Please enter a start date.")]
        [Display(Name = "Start Date")]
        [DisplayFormat(DataFormatString = "{0:MMM-dd-yyyy}")]
        public System.DateTime Start_Date { get; set; }

        [Display(Name = "End Date")]
        [DisplayFormat(DataFormatString = "{0:MMM-dd-yyyy}")]
        public Nullable<System.DateTime> End_Date { get; set; }

        [Display(Name = "Set to Repeat")]
        public bool Recurring_Status { get; set; }

        [Display(Name = "Occurs every")]
        public Nullable<int> Interval_Num { get; set; }

        [Display(Name = "Months or Weeks")]
        public string Interval_Type { get; set; }

    }

    public partial class Goal
    {
        public string Status { get; set; } //will hold the current status of the goal based on the test date (aka todays date)

        //will hold the date for the next interval. Ex. Start date = jan/01/2017 and the interval is 2 weeks, 
        //this will hold jan/14/2017 then on jan/14/2017 it will hold jan/28/2017
        [Display(Name = "Next Occurrence")]
        [DisplayFormat(DataFormatString = "{0:MMM-dd-yyyy}")]
        public Nullable<System.DateTime> Interval_Period_End_Date { get; set; }

        [Display(Name = "Amount Left")]
        public decimal Amount_Left { get; set; }
        [Display(Name = "Goal Interval Status")]
        public string Goal_Achieved { get; set; }

    }

    public class TransactionMetadata
    {
        [Display(Name = "Transaction ID")]
        public int Transaction_ID { get; set; }
        [Display(Name = "Account Type")]
        public string Account_Type { get; set; }
        [Display(Name = "Account Number")]
        public string Account_Number { get; set; }
        [Display(Name = "Processing Date")]
        [DataType(DataType.Date)]
        public System.DateTime Processing_Date { get; set; }
        [Display(Name = "Transaction Type")]
        public string Transaction_Type { get; set; }
        public decimal Amount { get; set; }
        public string Description { get; set; }

        public string Category { get; set; }
    }

    public partial class Transaction
    {

    }

}