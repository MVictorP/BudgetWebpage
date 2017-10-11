using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace BudgetWebpage.Models
{
    [MetadataType(typeof(AccountMetadata))]
    public partial class Account
    {
    }

    [MetadataType(typeof(BudgetMetadata))]
    public partial class Budget
    {
    }

    [MetadataType(typeof(CustomerMetadata))]
    public partial class Customer
    {
    }

    [MetadataType(typeof(GoalMetadata))]
    public partial class Goal
    {
    }

    [MetadataType(typeof(TransactionMetadata))]
    public partial class Transaction
    {
    }
}