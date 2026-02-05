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

namespace MyTestWebApp
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(true)]
        [ScriptMethod]
        public static bool InsertEmployeeData(string FirstName, string LastName, string Role, int Salary)
        {
            System.Diagnostics.Debug.WriteLine("Inserting Employee");
            System.Diagnostics.Debug.WriteLine(FirstName + " " + LastName + " " + Role + " " + Salary);
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocalDbConnString"].ToString()))
            {
                string query = "INSERT INTO Employee ([First Name], [Last Name], [Role], [Salary], [Active]) VALUES (@FirstName, @LastName, @Role, @Salary, @Active)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", FirstName);
                cmd.Parameters.AddWithValue("@LastName", LastName);
                cmd.Parameters.AddWithValue("@Role", Role);
                cmd.Parameters.AddWithValue("@Salary", Salary);
                cmd.Parameters.AddWithValue("@Active", true);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            return true;
        }
    }
}