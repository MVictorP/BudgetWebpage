using System;
using System.Data.SqlClient;
using Microsoft.AspNetCore.Mvc;

namespace BudgetPage.Controllers
{
    public class DatabaseController : Controller
    {
        public DatabaseController()
        {
            string connetionString = null;
            SqlConnection connection;
            SqlCommand command;
            string sql = null;
            SqlDataReader dataReader;
            connetionString = "Data Source=DESKTOP-U2SD1GJ;Initial Catalog=master;Integrated Security=True";
            sql = "Select * from data";
            connection = new SqlConnection(connetionString);
            try
            {
                connection.Open();
                command = new SqlCommand(sql, connection);
                dataReader = command.ExecuteReader();
                while (dataReader.Read())
                {
                    Console.WriteLine(dataReader.GetValue(0) + " - " + dataReader.GetValue(1) + " - " + dataReader.GetValue(2));
                }
                command.Dispose();
                connection.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Can not open connection ! ");
            }
        }
    }
}