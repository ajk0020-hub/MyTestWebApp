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
                DataTable dummy = new DataTable();
                dummy.Columns.Add("FirstName");
                dummy.Columns.Add("LastName");
                dummy.Columns.Add("Role");
                dummy.Columns.Add("Salary");
                dummy.Columns.Add("Employed");
                dummy.Rows.Add();
                gvEmployees.DataSource = dummy;
                gvEmployees.DataBind();

                //Required for jQuery DataTables to work.
                gvEmployees.UseAccessibleHeader = true;
                gvEmployees.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }


        [WebMethod]
        public static List<Employee> GetEmployees()
        {
            System.Diagnostics.Debug.WriteLine("Fetching Employees");
            List<Employee> employees = new List<Employee>();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStringDb"].ToString()))
            {
                string query = "SELECT * FROM Employees";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Employee employee = new Employee
                    {
                        FirstName = reader["FirstName"].ToString(),
                        LastName = reader["LastName"].ToString(),
                        Role = reader["Role"].ToString(),
                        Salary = Convert.ToInt32(reader["Salary"]),
                        Employed = Convert.ToBoolean(reader["Employed"])
                    };
                    employees.Add(employee);
                }
                conn.Close();
            }
            return employees;
        }
    }
}