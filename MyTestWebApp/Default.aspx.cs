using MyTestWebApp.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;

namespace MyTestWebApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

            }
        }

        // Returns a list of employees from the database upon AJAX request
        [WebMethod(true)]
        [ScriptMethod]
        public static List<Employee> GetEmployees()
        {
            List<Employee> employees = new List<Employee>();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocalDbConnString"].ToString()))
            {
                string query = "SELECT * FROM Employees";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Employee employee = new Employee
                    {
                        EmployeeId = Convert.ToInt32(reader["EmployeeId"]),
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