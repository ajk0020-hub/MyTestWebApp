<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddEmployee.aspx.cs" Inherits="MyTestWebApp.AddEmployee" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-row">
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="FirstNameForm" class="form-label">First Name</label>
            <input type="text" class="form-control" id="FirstNameForm" maxlength="49" pattern="[A-Za-z']+" title="Letters and Apostrophes Only" required runat="server" />
        </div>
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="LastNameForm" class="form-label">Last Name</label>
            <input type="text" class="form-control" id="LastNameForm" maxlength="49" pattern="[A-Za-z']+" title="Letters and Apostrophes Only" required runat="server" />
        </div>
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="RoleForm" class="form-label">Role</label>
            <input type="text" class="form-control" id="RoleForm" maxlength="49" required runat="server" />
        </div>
        <div class="form-group col-lg-3 col-md-6 col-sm-12">
            <label for="SalaryForm" class="form-label">Salary</label>
            <input type="number" class="form-control" id="SalaryForm" min="0" max="1000000" step="1" required runat="server" />
        </div>
    </div>
    <button class="btn btn-primary" type="submit">Submit form</button>
</asp:Content>
