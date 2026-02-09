<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditEmployee.aspx.cs" Inherits="MyTestWebApp.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Data Inputs. All are required. -->
    <div class="row">

        <!-- First name allows letters and apostrophes only and must be less than 50 characters -->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_FirstNameForm" class="form-label">First Name</label>
            <input disabled type="text" class="form-control" id="FirstNameForm" required runat="server" />
        </div>

        <!-- Last name allows letters and apostrophes only and must be less than 50 characters -->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_LastNameForm" class="form-label">Last Name</label>
            <input disabled type="text" class="form-control" id="LastNameForm" required runat="server" />
        </div>

        <!--Role must be less than 50 characters-->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_" class="form-label">Role</label>
            <input type="text" class="form-control" id="RoleForm" maxlength="49" required runat="server" />
        </div>

        <!-- Salary must be a positive integer less than 1 million -->
        <div class="col-lg-3 col-md-6 col-sm-12">
            <label for="MainContent_SalaryForm" class="form-label">Salary</label>
            <input type="number" class="form-control" id="SalaryForm" min="1" max="999999" step="1" required runat="server" />
        </div>
    </div>

    <!-- Employement Toggle -->
    <div class="col-2">
        <label for="MainContent_EmployedToggle">Employed</label>
        <input type="checkbox" id="EmployedToggle" runat="server" />
    </div>

    <!-- Save Button-->
    <button class="btn btn-primary" id="SubmitButton" type="submit">Save Changes</button>

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
            SubmitChanges();
        });

        function SubmitChanges() {
            __doPostBack();
        }
    </script>
</asp:Content>
