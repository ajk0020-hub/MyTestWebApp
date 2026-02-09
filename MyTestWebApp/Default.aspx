<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MyTestWebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- DataTables and Bootstrap Icons CSS references -->
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.7/css/dataTables.dataTables.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <main>
        <!-- Page Title -->
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">Employee Search</h1>
        </section>

        <!-- Add Employee Button -->
        <a class="btn bg-dark text-light" href="AddEmployee.aspx">Add Employee</a>

        <!-- Employee Data Table -->
        <div>
            <table id="EmployeesTable" class="table table-striped">
                <thead>
                    <tr>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>

        <!-- Scripts -->
        <script type="text/javascript" src="https://cdn.datatables.net/2.3.7/js/dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">

            //JQuery to get all employees in the database
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

            //Assigns the employees' data to EmployeesTable
            function OnSuccess(response) {
                $('#EmployeesTable').DataTable(
                    {
                        bLengthChange: true,
                        lengthMenu: [[10, 25, 50], [10, 25, 50]],
                        bFilter: true,
                        bSort: true,
                        bPaginate: true,
                        data: response.d,
                        columns: [
                        {
                            'data': 'EmployeeId',
                            'title': '',
                            'orderable': false,
                            'width': '1px',
                                'render': function (data, type, row) {
                                    if (type === 'display') {
                                        return '<a class="bi bi-pencil-square" href="EditEmployee?id=' + encodeURIComponent(data) + '"></a>';
                                    }
                                    return data;
                            }
                        },
                        {
                            'data': 'FirstName',
                            'title': 'First Name'
                        },
                        {
                            'data': 'LastName',
                            'title': 'Last Name'
                        },
                        {
                            'data': 'Role',
                            'title': 'Role'
                        },
                        {
                            'data': 'Salary',
                            'title': 'Salary',
                            'render': function (data, type, row) {
                                if (type === 'display') {
                                    return '$' + data;
                                }
                                return data;
                            }
                        },
                        {
                            'data': 'Employed',
                            'title': 'Employed',
                            'render': function (data, type, row) {
                                if (type === 'display') {
                                    if (data === true) {
                                        return '<i class="bi bi-check-lg" ></i>';
                                    }
                                    else if (data === false) {
                                        return '<i class="bi bi-x-lg"></i>';
                                    }
                                    else {
                                        return data;
                                    }
                                }
                                return data;
                            }
                        }],
                        columnDefs: [
                            {
                                targets: 5,
                                className: 'dt-center'
                            }
                        ]
                    });
            };
        </script>
    </main>
</asp:Content>
