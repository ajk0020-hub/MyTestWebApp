using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyTestWebApp.Models
{
    public class Employee
    {
        public int EmployeeId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Role { get; set; }
        public int Salary { get; set; }
        public bool Employed { get; set; }
    }
}