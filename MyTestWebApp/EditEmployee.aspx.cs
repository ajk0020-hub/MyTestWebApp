using MyTestWebApp.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyTestWebApp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                LoadEmployeeInfo();
            }
            else
            {
                if (UpdateEmployeeInfo())
                {
                    Response.Redirect("~/Default");
                }
                else
                {
                    Response.Write("<script>alert('Error: Employee information could not be updated.');</script>");
                }
            }
        }

        //Loads the employee information from the database and populates the form fields with it
        void LoadEmployeeInfo()
        {
            //Get EmployeeId from the url
            int id = Convert.ToInt32(Request.QueryString["id"]);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocalDbConnString"].ToString()))
            {
                //Get the employee information from the database
                string query = "SELECT * FROM Employees WHERE [EmployeeId]=" + id;
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                //Populate the form fields with the employee information
                while (reader.Read())
                {
                    FirstNameForm.Value = reader["First Name"].ToString();
                    LastNameForm.Value = reader["Last Name"].ToString();
                    RoleForm.Value = reader["Role"].ToString().Trim();
                    SalaryForm.Value = reader["Salary"].ToString().Trim();
                    EmployedToggle.Checked = Convert.ToBoolean(reader["Active"]);
                }
                conn.Close();
            }
        }

        //Saves the employee information from the form fields to the database. Returns true upon a successful save and false otherwise.
        bool UpdateEmployeeInfo()
        {
            //Input Validation
            if (Convert.ToInt32(SalaryForm.Value) <= 0 || Convert.ToInt32(SalaryForm.Value) >= 1000000)
            {
                System.Diagnostics.Debug.WriteLine("Invalid Salary");
                return false;
            }
            if (RoleForm.Value.Length >= 50)
            {
                System.Diagnostics.Debug.WriteLine("Role Input Too Long");
                return false;
            }

            //Get EmployeeId from the url
            int id = Convert.ToInt32(Request.QueryString["id"]);

            //Save the employee information to the database
            int check = 0;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["LocalDbConnString"].ToString()))
            {
                string query = "UPDATE Employees SET [First Name]=@FirstName, [Last Name]=@LastName, [Role]=@Role, [Salary]=@Salary, [Active]=@Active WHERE EmployeeId=" + id;
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", FirstNameForm.Value);
                cmd.Parameters.AddWithValue("@LastName", LastNameForm.Value);
                cmd.Parameters.AddWithValue("@Role", RoleForm.Value);
                cmd.Parameters.AddWithValue("@Salary", SalaryForm.Value);
                cmd.Parameters.AddWithValue("@Active", EmployedToggle.Checked);
                conn.Open();
                check = cmd.ExecuteNonQuery();
                conn.Close();
            }

            //If 0 rows are affected, then the query did not execute successfully, so return false
            return !(check == 0);
        }
    }
}