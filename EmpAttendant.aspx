<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="EmpAttendant.aspx.cs" Inherits="Attedant.EmpAttendant" %>


<asp:Content ID="EmpAbsent" runat="server" ContentPlaceHolderID="MainContent">

  <style>
        .editForm .dxgvEditFormTable {
            width: 175% !important;
        }

        .myUpperClass {
            text-transform: uppercase;
        }
    </style>
    <script>
        function InfoTanggal() {
            window.setTimeout("cbEmp.Focus()", 10);
        }
        function disableEnterKey(event) {
            if (event.keyCode === 13) { // Check if the pressed key is Enter (key code 13)
                event.preventDefault(); // Prevent the default action of Enter key
                return false; // Return false to stop event propagation
            }
        }
    </script>

<%--    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>--%>
    <section class="content" style="width: 120%">
        <div class="col-lg-12">
            <div class="card card-info">
                <div class="card-header" style="font-size: small">
                    <h5 class="card-title">Employee TimeAbsenteesmn</h5>
                </div>
                <div class="card-body" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: medium" runat="server">
                    <dx:ASPxGridView ID="gvAbsent" runat="server" Width="100%" Theme="Metropolis" AutoGenerateColumns="False"
                        OnDataBinding="gvAbsent_DataBinding"
                        OnRowUpdating="gvAbsent_RowUpdating"
                        OnCustomButtonCallback="gvAbsent_CustomButtonCallback"
                        CausesValidation="false" Settings-HorizontalScrollBarMode="Auto" Font-Size="Medium"
                        KeyFieldName="EmployeeNo;Tanggal">
                        <SettingsDataSecurity AllowEdit="true" AllowDelete="true" AllowInsert="false" />
                        <SettingsBehavior AllowSelectSingleRowOnly="true" AllowSelectByRowClick="true" />
                        <Settings ShowFilterRow="true" ShowFilterBar="Auto" />
                        <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                        <Columns>
                            <dx:GridViewCommandColumn ShowNewButtonInHeader="True" VisibleIndex="0" Width="100px" HeaderStyle-HorizontalAlign="Center" FixedStyle="Left">
                                <HeaderTemplate>
                                    <dx:ASPxButton ID="btnAdd" ClientInstanceName="btnAdd" runat="server" AutoPostBack="false"
                                        Style="border: none; background: none" ToolTip="Add Record" OnClick="btnAdd_Click">
                                        <Image Url="../Icon/Create.png" Height="25px" Width="27px"></Image>
                                        <%--<ClientSideEvents Click="function(s, e) { POPEntry.Show(); }" />--%>
                                    </dx:ASPxButton>
                                </HeaderTemplate>
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton ID="Edit" Styles-Native="true" Image-ToolTip="Edit Record"
                                        Styles-Style-CssClass="btn btn-info btn-md btn-rounded mr-1" Text="Edit  "
                                        Styles-Style-ForeColor="White">
                                    </dx:GridViewCommandColumnCustomButton>

                                    <%--  <dx:GridViewCommandColumnCustomButton ID="Del" Text="Delete" Styles-Style-ForeColor="Red">
                                    </dx:GridViewCommandColumnCustomButton>--%>
                                </CustomButtons>
                                <CellStyle VerticalAlign="Top"></CellStyle>
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="EmployeeNo" VisibleIndex="1" Caption="NIP" Width="110" ReadOnly="true" FixedStyle="Left"
                                HeaderStyle-Wrap="True">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="AbsenteeismNo" VisibleIndex="2" Caption="NIK" Width="110" ReadOnly="true" FixedStyle="Left"
                                HeaderStyle-Wrap="True">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="FullName" VisibleIndex="3" Caption="Full Name" Width="250" ReadOnly="true" FixedStyle="Left"
                                HeaderStyle-Wrap="True">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Tanggal" VisibleIndex="4" Caption="Transaction Date" Width="100" ReadOnly="true" FixedStyle="Left"
                                HeaderStyle-Wrap="True">
                                <PropertiesTextEdit DisplayFormatString="yyyy-MM-dd" />
                            </dx:GridViewDataTextColumn>                           

                            <dx:GridViewDataTextColumn FieldName="ShiftCode" VisibleIndex="6" Caption="Shift Code" Width="80"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left">
                                <CellStyle CssClass="myUpperClass">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ShiftType" VisibleIndex="7" Caption="Shift Type" Width="50"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DateIN" VisibleIndex="8" Caption="Date In" Width="100"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left">
                                <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="DateOut" VisibleIndex="9" Caption="Date Out" Width="100"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left">
                                <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Time_In" VisibleIndex="10" Caption="Time In" Width="100"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left">
                                <PropertiesTextEdit DisplayFormatString="HH:mm" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Time_Out" VisibleIndex="11" Caption="Time Out" Width="100"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left">
                                <PropertiesTextEdit DisplayFormatString="HH:mm" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="AbsentCode" VisibleIndex="12" Caption="Kode Absen" Width="80"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                <CellStyle CssClass="myUpperClass" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataCheckColumn FieldName="FlagShortDay" VisibleIndex="13" Caption="Flg ShortHoliday" Width="70"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Center">
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="FlagHoliday" VisibleIndex="14" Caption="Flg Holiday" Width="70"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Center">
                            </dx:GridViewDataCheckColumn>
                        </Columns>
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" Landscape="true" PaperKind="LegalExtra" />
                        <ClientSideEvents CustomButtonClick="function (s, e) { if (e.buttonID == 'Del') e.processOnServer = confirm('Do you really want to Delete this record ..?');
                                             if (e.buttonID == 'Edit') s.StartEditRow(e.visibleIndex); 
                                             if (e.buttonID == 'New') window.open('#');   }" />
                        <SettingsPager PageSize="31">
                            <PageSizeItemSettings Visible="false" ShowAllItem="true" />
                        </SettingsPager>
                        <Styles>
                            <Header BackColor="SlateGray" Font-Size="Medium" CssClass="accent-white"></Header>
                            <EditForm CssClass="editForm"></EditForm>
                        </Styles>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
    </section>
    <section>
        <asp:UpdatePanel ID="Input" runat="server">
            <ContentTemplate>
                <!--------------------------------------------------------------------- Modal ---------------------------------------------------------------------------------------------->
                <div class="modal toasts-top-right" id="ModalInput" visible="false" runat="server" tabindex="-1" role="dialog" aria-labelledby="MyLargeModal"
                    aria-hidden="false" style="display: block; top: 50px; position: center; overflow-y: scroll; font-size: smaller;">
                    <div class="container">
                        <div class="modal-dialog modal-dialog-scrollable" role="document">
                            <div class="modal-content">
                                <div class="modal-header text-left">
                                    <h5 class="modal-title" id="lJudule" runat="server">Input Employee Absensi </h5>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label>Transaction Date</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                                    <dx:ASPxDateEdit ID="EdTanggal" runat="server" ClientInstanceName="EdTanggal" ClientEnabled="true" Width="400px" NullText="dd-mm-yyyy" Height="32px"
                                                        EditFormatString="dd-MM-yyyy" onkeydown="return disableEnterKey(event) ">
                                                        <ClientSideEvents DateChanged="InfoTanggal" />
                                                        <ValidationSettings ErrorDisplayMode="ImageWithText" Display="Dynamic" ErrorFrameStyle-ImageSpacing="0">
                                                            <RequiredField IsRequired="True" />
                                                        </ValidationSettings>
                                                    </dx:ASPxDateEdit>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label>Employee Name</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"><i class="far fa-clone"></i></span>
                                                    <%--               <asp:UpdatePanel ID="UpdtPnlEmp" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate> --%>
                                                    <dx:ASPxComboBox ID="cbEmp" runat="server" Width="400px" ClientInstanceName="cbEmp" onkeydown="return disableEnterKey(event)"
                                                        DropDownStyle="DropDown" TextField="FullName" AutoPostBack="true" ValueField="EmployeeNo"
                                                        IncrementalFilteringMode="StartsWith" EnableSynchronization="False" DataSourceID="EmpDataSource"
                                                        OnSelectedIndexChanged="cbEmp_SelectedIndexChanged" TextFormatString="{1}"
                                                        EnableTheming="true" Theme="MaterialCompact" Enabled="true" NullText="Nama Employee ">
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="EmployeeNo" Caption="NIP" Width="100px" />
                                                            <dx:ListBoxColumn FieldName="FullName" Caption="Full Name" Width="200px" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <%--    </ContentTemplate>
                                          <Triggers>
                                            <asp:PostBackTrigger ControlID="cbEmp" />
                                        </Triggers>
                                    </asp:UpdatePanel>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label>Jam Masuk</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="far fa-times-circle"></i></span>
                                                        <dx:ASPxTextBox ID="TimeIn" runat="server" ClientInstanceName="TimeIn" ToolTip="Jam Masuk" Width="100px"
                                                            EnableTheming="true" Theme="MaterialCompact" 
                                                            HorizontalAlign="Right" Font-Size="Small" AutoPostBack="false" NullText="00:00:00">
                                                            <MaskSettings Mask="<00:00:00>" />
                                                            <ValidationSettings ErrorDisplayMode="ImageWithText" Display="Dynamic" ErrorFrameStyle-ImageSpacing="0">
                                                                <RequiredField IsRequired="True" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                       <%-- <dx:ASPxTimeEdit ID="TimeInx" runat="server" Width="100" ClientInstanceName="TimeInx"
                                                            DisplayFormatString="HH:mm:ss">
                                                            <%-- <ClearButton DisplayMode="OnHover"></ClearButton>--
                                                            <ValidationSettings ErrorDisplayMode="None" />
                                                        </dx:ASPxTimeEdit>--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label>Jam Pulang</label>
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text"><i class="far fa-times-circle"></i></span>
                                                        <dx:ASPxTextBox ID="TimeOut" runat="server" ClientInstanceName="TimeOut" ToolTip="Jam Pulang" Width="100px"
                                                            EnableTheming="true" Theme="MaterialCompact" 
                                                            HorizontalAlign="Right" Font-Size="Small" AutoPostBack="false" NullText="00:00:00">
                                                            <MaskSettings Mask="<00:00:00>" />
                                                            <ValidationSettings ErrorDisplayMode="ImageWithText" Display="Dynamic" ErrorFrameStyle-ImageSpacing="0">
                                                                <RequiredField IsRequired="True" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                        <%--<dx:ASPxTimeEdit ID="TimeOut" runat="server" Width="100" ClientInstanceName="TimeOut"
                                                            DisplayFormatString="HH:mm:ss">
                                                            <%-- <ClearButton DisplayMode="OnHover"></ClearButton>--
                                                            <ValidationSettings ErrorDisplayMode="None" />

                                                        </dx:ASPxTimeEdit>--%>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label>Abseentsmn Code</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"><i class="far fa-edit"></i></span>
                                                    <%--      <asp:UpdatePanel ID="UpdtPnlKode" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>--%>
                                                    <dx:ASPxComboBox ID="cbAbsent" runat="server" Width="400px" ClientInstanceName="cbAbsent"
                                                        DropDownStyle="DropDown" TextField="KETER" AutoPostBack="true" ValueField="ACC" onkeydown="return disableEnterKey(event) "
                                                        IncrementalFilteringMode="StartsWith" EnableSynchronization="False" DataSourceID="AbsentDataSource"
                                                        OnSelectedIndexChanged="cbAbsent_SelectedIndexChanged" TextFormatString="{1}"
                                                        EnableTheming="true" Theme="MaterialCompact" Enabled="true" NullText="Kode Presensi ">
                                                        <Columns>
                                                            <dx:ListBoxColumn FieldName="ACC" Caption="Kode" Width="50px" />
                                                            <dx:ListBoxColumn FieldName="KETER" Caption="Keterangan" Width="200px" />
                                                        </Columns>
                                                    </dx:ASPxComboBox>
                                                    <%--         </ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <label>Remarks</label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"><i class="far fa-city"></i></span>
                                                    <%--   <asp:UpdatePanel ID="UpPnlNotes" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate> --%>
                                                    <dx:ASPxMemo ID="EdNotes" runat="server" Width="400px" Theme="MaterialCompact" Height="10%"
                                                        Rows="4" HorizontalAlign="Left">
                                                        <ClientSideEvents KeyUp="function(s, e) { var txt = s.GetText(); s.SetText(txt.toUpperCase()); }" />
                                                    </dx:ASPxMemo>
                                                    <%-- </ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer" style="font-size: small">
                                    <asp:Button runat="server" ID="btnSaveRecord" Text="Save Record" CssClass="btn btn-primary" OnClick="btnSaveRecord_Click" />
                                    <asp:Button runat="server" ID="btnCloseRecord" Text="Close" CssClass="btn btn-secondary" OnClick="btnCloseRecord_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </section>
    <asp:SqlDataSource ID="dbShift" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnection %>"
        DataSourceMode="DataReader"
        SelectCommand="SP_TimeShift"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dbPresensi" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnection %>"
        DataSourceMode="DataReader"
        SelectCommand="SP_Presensi"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="EmpDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnection %>"
        DataSourceMode="DataReader"
        SelectCommand="SP_Employee"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="AbsentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnection %>"
        DataSourceMode="DataReader"
        SelectCommand="SP_Presensi"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
