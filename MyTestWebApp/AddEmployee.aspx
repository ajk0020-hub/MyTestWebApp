<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="MyTestWebApp.AddEmployee" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-row">
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_FirstNameForm" class="form-label">First Name</label>
            <input type="text" class="form-control" id="FirstNameForm" maxlength="49" pattern="[A-Za-z']+" title="Letters and Apostrophes Only" required runat="server" />
        </div>
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_LastNameForm" class="form-label">Last Name</label>
            <input type="text" class="form-control" id="LastNameForm" maxlength="49" pattern="[A-Za-z']+" title="Letters and Apostrophes Only" required runat="server" />
        </div>
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_" class="form-label">Role</label>
            <input type="text" class="form-control" id="RoleForm" maxlength="49" required runat="server" />
        </div>
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_SalaryForm" class="form-label">Salary</label>
            <input type="number" class="form-control" id="SalaryForm" min="0" max="1000000" step="1" required runat="server" />
        </div>
    </div>
    <button class="btn btn-primary" onclick="SubmitEmployee()">Save</button>

    <script type="text/javascript">
        function SubmitEmployee() {
            $.ajax({
                type: "POST",
                url: "AddEmployee.aspx/InsertEmployeeData",
                data: JSON.stringify({
                    FirstName: document.getElementById("MainContent_FirstNameForm").value,
                    LastName: document.getElementById("MainContent_LastNameForm").value,
                    Role: document.getElementById("MainContent_RoleForm").value,
                    Salary: document.getElementById("MainContent_SalaryForm").value
                }),
                contentType: "application/json; charset=utf-8",
                success: function () {
                    if (response.d === false) {
                        alert("Failed to insert employee's data");
                    }
                    else if (response.d === true) {
                        alert("proper response");
                    }
                    else {
                        alert("How did we get here?");
                    }
                },
                failure: function () {
                    alert("failed" + response.d);
                },
                error: function () {
                    alert("Error" + response.d);
                }
            })
            //alert("Past the Ajax");
            document.getElementById("MainContent_FirstNameForm").value = "";
            document.getElementById("MainContent_LastNameForm").value = "";
            document.getElementById("MainContent_RoleForm").value = "";
            document.getElementById("MainContent_SalaryForm").value = "";
        }
    </script>
</asp:Content>
