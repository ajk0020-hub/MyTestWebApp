using MyTestWebApp.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace MyTestWebApp
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Inserts a new employee into the database upon AJAX request. Returns true upon a successful save and false otherwise.
        [WebMethod(true)]
        [ScriptMethod]
        public static bool InsertEmployeeData(string FirstName, string LastName, string Role, int Salary)
        {
            //Input Validation
            if (FirstName.Length >=50 || LastName.Length >=50 || Role.Length >= 50)
            {
                System.Diagnostics.Debug.WriteLine("Input Too Long");
                return false;
            }
            if(!Regex.IsMatch(FirstName, @"^[a-zA-Z']+$") || !Regex.IsMatch(LastName, @"^[a-zA-Z']+$"))
            {
                System.Diagnostics.Debug.WriteLine("Invalid Name");
                return false;
            }
            if(Salary <= 0 || Salary >= 1000000)
            {
                System.Diagnostics.Debug.WriteLine("Invalid Salary");
                return false;
            }

            int check = 0;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocalDbConnString"].ToString()))
            {
                string query = "INSERT INTO Employees ([First Name], [Last Name], [Role], [Salary], [Active]) VALUES (@FirstName, @LastName, @Role, @Salary, @Active)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", FirstName);
                cmd.Parameters.AddWithValue("@LastName", LastName);
                cmd.Parameters.AddWithValue("@Role", Role);
                cmd.Parameters.AddWithValue("@Salary", Salary);
                cmd.Parameters.AddWithValue("@Active", true);
                conn.Open();
                check = cmd.ExecuteNonQuery();
                conn.Close();
            }

            //If 0 rows are affected, then the query did not execute successfully, so return false
            return !(check == 0);
        }
    }
}