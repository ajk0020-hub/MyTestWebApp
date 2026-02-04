<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyTestWebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">Employee Search</h1>
        </section>

        <div>
            <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                    <asp:BoundField DataField="Role" HeaderText="Role" />
                    <asp:BoundField DataField="Salary" HeaderText="Salary" />
                    <asp:BoundField DataField="Employed" HeaderText="Employed" />
                </Columns>
            </asp:GridView>
        </div>

        
        <script type="text/javascript" src="https://cdn.datatables.net/2.3.7/css/dataTables.dataTables.min.css"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/2.3.7/js/dataTables.min.js"></script>
        <script type="text/javascript">
            $(function () {
                console.log("Calling ajax now.");
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetEmployees",
                    contentType: "application/json; charset=utf-8",
                    success: OnSuccess,
                    failure: function (response) {
                        console.log("Failed response");
                        alert(response.d);
                    },
                    error: function (response) {
                        console.log("Error response");
                        alert(response.d);
                    }
                });
            });

            function OnSuccess(response) {
                console.log("Succeeded response");
                $("[id*=gvEmployees]").DataTable(
                    {
                        bLengthChange: true,
                        lengthMenu: [[10, 25, 50], [10, 25, 50]],
                        bFilter: true,
                        bSort: true,
                        bPaginate: true,
                        data: response.d,
                        columns: [{ 'data': 'FirstName' },
                        { 'data': 'LastName' },
                        { 'data': 'Role' },
                        { 'data': 'Salary' },
                        { 'data': 'Employed' }]
                    });
            };
        </script>
    </main>
</asp:Content>
