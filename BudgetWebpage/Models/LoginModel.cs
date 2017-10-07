using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BudgetWebpage.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "Please enter user name.")]
        [DataType(DataType.Text)]
        [Display(Name = "User Name")]
        [StringLength(30)]
        public string Username { get; set; }

        [Required(ErrorMessage = "Please enter password.")]
        [DataType(DataType.Text)]
        [Display(Name = "Password")]
        [StringLength(10)]
        public string Password { get; set; }

        [Required(ErrorMessage = "Please enter a Date.")]
        [DataType(DataType.Date)]
        [Display(Name = "Enter a Date")]
        [Range(typeof(DateTime), "1/11/2016", "1/30/2017",
            ErrorMessage = "Date must be between {1:MM/dd/yy} and {2:MM/dd/yy}")]
        public System.DateTime Test_Date { get; set; }
    }

    [Table("Customer")]
    public class Cust
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public int Customer_ID { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public System.DateTime Test_Date { get; set; }
    }
}