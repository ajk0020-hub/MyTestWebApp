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
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                System.Diagnostics.Debug.WriteLine("Page Loaded");
            }
        }


        [WebMethod(true)]
        [ScriptMethod]
        public static List<Employee> GetEmployees()
        {
            System.Diagnostics.Debug.WriteLine("Fetching Employees");
            List<Employee> employees = new List<Employee>();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocalDbConnString"].ToString()))
            {
                string query = "SELECT * FROM Employee";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Employee employee = new Employee
                    {
                        FirstName = reader["First Name"].ToString(),
                        LastName = reader["Last Name"].ToString(),
                        Role = reader["Role"].ToString(),
                        Salary = Convert.ToInt32(reader["Salary"]),
                        Employed = Convert.ToBoolean(reader["Active"])
                    };
                    employees.Add(employee);
                }
                conn.Close();
            }
            return employees;
        }
    }
}