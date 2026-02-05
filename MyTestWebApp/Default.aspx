<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyTestWebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.7/css/dataTables.dataTables.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css">
    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">Employee Search</h1>
        </section>
        <a class="btn bg-dark text-light" href="AddEmployee.aspx">Add Employee</a>
        <div>
            <table id="gvEmployees" class="table table-striped">
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Role</th>
                        <th>Salary</th>
                        <th>Employed</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>

        <script type="text/javascript" src="https://cdn.datatables.net/2.3.7/js/dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">
            $(function () {
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
                $('#gvEmployees').DataTable(
                    {
                        columnDefs: [
                            {
                                targets: 3,
                                render: function (data, type, row) {
                                    if (type === 'display') {
                                        return '$' + data;
                                    }
                                    return data;
                                }
                            },
                            {
                                targets: 4,
                                render: function (data, type, row) {
                                    if (type === 'display') {
                                        if (data === true) {
                                            return 'Active';
                                        }
                                        else if (data === false) {
                                            return 'Inactive';
                                        }
                                        else {
                                            return data;
                                        }
                                    }
                                    return data;
                                }
                            }
                        ],
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
