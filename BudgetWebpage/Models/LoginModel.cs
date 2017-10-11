using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;


//Used this as a guide:
//http://www.dotnetlearners.com/blogs/view/124/Login-Page-Example-In-MVC-Using-Entity-Frame-Work.aspx
namespace BudgetWebpage.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "Please enter user name.")]
        [DataType(DataType.Text)]
        [Display(Name = "Username")]
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
        [Range(typeof(DateTime), "11/01/2016", "1/30/2017",
            ErrorMessage = "Date must be between {1:MM/dd/yy} and {2:MM/dd/yy}")]
        public DateTime Test_Date { get; set; }
    }

    public class User
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public DateTime Test_Date { get; set; }
    }
}