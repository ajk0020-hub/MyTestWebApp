<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="MyTestWebApp.AddEmployee" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Data Inputs. All are required. -->
    <div class="row">

        <!-- First name allows letters and apostrophes only and must be less than 50 characters -->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="FirstNameForm" class="form-label">First Name</label>
            <input type="text" class="form-control" id="FirstNameForm" maxlength="49" pattern="[A-Za-z']+" title="Letters and Apostrophes Only" required" />
        </div>

        <!-- Last name allows letters and apostrophes only and must be less than 50 characters -->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="LastNameForm" class="form-label">Last Name</label>
            <input type="text" class="form-control" id="LastNameForm" maxlength="49" pattern="[A-Za-z']+" title="Letters and Apostrophes Only" required />
        </div>

        <!--Role must be less than 50 characters-->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="" class="form-label">Role</label>
            <input type="text" class="form-control" id="RoleForm" maxlength="49" required />
        </div>

        <!-- Salary must be a positive integer less than 1 million -->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="SalaryForm" class="form-label">Salary</label>
            <input type="number" class="form-control" id="SalaryForm" min="1" max="999999" step="1" required />
        </div>
    </div>

    <!-- Save Button-->
    <button class="btn btn-primary" type="submit" >Save</button>

    <!-- Scripts -->
    <script type="text/javascript">

        //Form validity check
        const form = document.getElementById('MainForm');
        form.addEventListener('submit', function (event) {

            //Do nothing if the form is invalid
            if (!form.checkValidity()) {
                event.preventDefault();
                return;
            }

            //Save employee's data if the form is valid
            event.preventDefault();
            SubmitEmployee();
        });

        //Sends new employee data to the server. Redirects the user to the employee search page upon successful save and alerts the user otherwise.
        function SubmitEmployee() {
            alert("Submitting");
            $.ajax({
                type: "POST",
                url: "AddEmployee.aspx/InsertEmployeeData",
                data: JSON.stringify({
                    FirstName: document.getElementById("FirstNameForm").value,
                    LastName: document.getElementById("LastNameForm").value,
                    Role: document.getElementById("RoleForm").value,
                    Salary: document.getElementById("SalaryForm").value
                }),
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    if (response.d === true) {
                        //alert("Employee's data saved");
                        window.location.href = "Default.aspx";
                    }
                    else {
                        alert("Failed to save employee's data");
                    }
                },
                failure: function (response) {
                    alert("Failure" + response.d);
                },
                error: function (response) {
                    alert("Error" + response.d);
                }
            });
        }
    </script>
</asp:Content>
