<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Capture.aspx.cs" Inherits="Attedant.Capture" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="EmpCapture" runat="server" ContentPlaceHolderID="MainContent">

  <script>

</script>
    <%--<asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>--%>
    <section class="content">
        <div class="col-lg-10">
            <div class="card card-info">
                <div class="card-header" style="font-size: small">
                    <h5 class="card-title">Employee Capture</h5>
                </div>
                <div class="card-body" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: small" runat="server">
                    <div class="content" style="margin-left: 10px">
                        <div class="row">
                            <div class="col-md-6">
                               <%-- <asp:UpdatePanel ID="UpdGanti" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
                                    <ContentTemplate>--%>
                                        <div class="form-group">
                                            <label>Periode </label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text"><i class="far fa-building"></i></span>
                                                    <dx:aspxcombobox runat="server" id="cmbPeriode" clientinstancename="cmbPeriode" theme="MaterialCompact"
                                                        dropdownstyle="DropDown" textfield="keterangan" width="100%" autopostback="true" onselectedindexchanged="cmbPeriode_SelectedIndexChanged"
                                                        valuefield="mp" incrementalfilteringmode="StartsWith" enablesynchronization="False">
                                                    </dx:aspxcombobox>
                                                </div>
                                            </div>
                                        </div>
                                    <%--</ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="cmbPeriode" />
                                    </Triggers>
                                </asp:UpdatePanel>--%>
                            </div>
                            <div class="col-md-3" style="margin-top: 30px">
                                <asp:FileUpload runat="server" ID="FileUpload" AllowMultiple="true" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.txt)$"
                                    ControlToValidate="FileUpload" runat="server" ForeColor="Red" ErrorMessage="Please select a valid txt file."
                                    Display="Dynamic" />
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                <br />
                                <small>Allowed file extensions: .txt</small>
                                <br />
                                <small>Maximum file size: 4 MB.</small>
                            </div>
                            <div class="col-md-3" style="margin-top: 25px">
                                <asp:Button runat="server" ID="btnGetCapture" Text="Get Capture " CssClass="btn btn-success btn-md btn-rounded" Width="150px"
                                    Font-Size="Small" ToolTip="Get Data from Finger Text File" OnClick="btnGetCapture_Click" />
                            </div>
                        </div>
                    </div>
                    <dx:aspxgridview id="gvCapture" clientinstancename="gvCapture" runat="server" autogeneratecolumns="false"
                        ondatabinding="gvCapture_DataBinding" font-size="Medium"
                        keyfieldname="EmployeeNo" showfooter="true" settings-horizontalscrollbarmode="Auto"
                        enablerowscache="false" keyboardsupport="true" accesskey="D"
                        theme="MetropolisBlue" width="100%">
                        <SettingsBehavior AllowSelectSingleRowOnly="true" AllowSelectByRowClick="true" />
                        <Settings AutoFilterCondition="Contains" />
                        <Settings ShowFooter="true" />
                        <Settings ShowFilterRow="true" ShowFilterBar="Auto" />
                        <SettingsEditing Mode="EditFormAndDisplayRow"></SettingsEditing>
                        <Columns>

                            <dx:GridViewDataTextColumn FieldName="Tanggal" VisibleIndex="0" Caption="Tanggal" Width="100"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left" FixedStyle="Left" ReadOnly="true">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="EmployeeNo" VisibleIndex="1" Caption="NIP" Width="110"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left" FixedStyle="Left" ReadOnly="true">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="FullName" VisibleIndex="2" Caption="Full Name" Width="250"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left" FixedStyle="Left" ReadOnly="true">
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn FieldName="Jam" VisibleIndex="3" Caption="Jam" Width="100"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left" FixedStyle="Left" ReadOnly="true">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="4" Caption="Note" Width="250"
                                HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Left" FixedStyle="Left" ReadOnly="true">
                            </dx:GridViewDataTextColumn>

                        </Columns>
                        <SettingsPager PageSize="10">
                            <PageSizeItemSettings Visible="false" ShowAllItem="true" />
                        </SettingsPager>
                        <Styles>
                            <Header BackColor="#006666" Font-Size="Medium" CssClass="accent-white"></Header>
                        </Styles>
                        <SettingsDetail ShowDetailRow="false" AllowOnlyOneMasterRowExpanded="false" />
                        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" Landscape="true" PaperKind="LegalExtra" />
                    </dx:aspxgridview>
                    <dx:aspxgridviewexporter id="ASPxGridViewExporter" runat="server">
                        <Styles>
                            <Cell Font-Names="Arial" Font-Size="Small"></Cell>
                            <AlternatingRowCell Wrap="True"></AlternatingRowCell>
                            <Header Font-Names="Arial" Font-Size="Large" HorizontalAlign="Center"></Header>
                        </Styles>
                    </dx:aspxgridviewexporter>
                    <br />
                    <div class="modal-footer-full-width  modal-footer">
                        <asp:Button runat="server" ID="btnToPDF" Text="Export PDF" CssClass="btn btn-secondary btn-md btn-rounded" Width="100px"
                            Font-Size="Small" OnClick="btnToPDF_Click" />
                        <asp:Button runat="server" ID="btnToExcel" Text="Export Xls" CssClass="btn btn-warning btn-md btn-rounded" Width="100px"
                            Font-Size="Small" OnClick="btnToExcel_Click" />
                        <asp:Button runat="server" ID="btnClose" Text="Close" CssClass="btn btn-primary btn-md btn-rounded" Width="100px"
                            Font-Size="Small" OnClick="btnClose_Click" />
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

