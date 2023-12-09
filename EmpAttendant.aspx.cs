using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using DevExpress.Web;
using System.Reflection;
using System.IO;
using System.Data.OleDb;


namespace Attedant
{
    public partial class EmpAttendant : System.Web.UI.Page
    {
        string conString = ConfigurationManager.ConnectionStrings["HRConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Inits();
                gvAbsent.DataBind();
            }
        }
        protected void Inits()
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_CHECK_USERID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", "alie");
                SqlDataReader dr = cmd.ExecuteReader();
                dr.Read();
                // Jika data ditemukan
                if (dr.HasRows)
                {
                    Session["User"] = dr["LoginID"].ToString();
                    Session["lAda"] = dr["LoginID"].ToString();
                    Session["Tgl1"] = dr["Tgl1"].ToString();
                    Session["Tgl2"] = dr["Tgl2"].ToString();
                    Session["Tanggal1"] = dr["Tanggal1"].ToString();
                    Session["Tanggal2"] = dr["Tanggal2"].ToString();
                    Session["VKPeriode"] = dr["VKeter"].ToString();
                    Session["VPeriode"] = dr["MP"].ToString();
                    Session["VTahun"] = dr["MT"].ToString();
                    Session["MStatus"] = dr["MS"].ToString();
                }
                else
                {
                    Session["lAda"] = null;
                }
                dr.Close();
                con.Close();
            }

        }
        protected void gvAbsent_DataBinding(object sender, EventArgs e)
        {
            gvAbsent.DataSource = GetDataAbsent();
        }
        protected DataTable GetDataAbsent()
        {
            string isiTgl1 = Session["Tgl1"].ToString();
            string isiTgl2 = Session["Tgl2"].ToString();
            // TimeIn.Text = "07:00:00"; TimeOut.Text = "17:00:00";
            DateTime dTgl1 = DateTime.Parse(Session["Tgl1"].ToString());
            DateTime dTgl2 = DateTime.Parse(Session["Tgl2"].ToString());
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_EmployeeAbsent", con);
                cmd.Parameters.AddWithValue("@dTgl1", dTgl1);
                cmd.Parameters.AddWithValue("@dTgl2", dTgl2);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 70200;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                con.Close();
            }
            return dt;
        }
        protected void gvAbsent_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            string bulan = string.Empty; string tahun = string.Empty; string Jumlah = string.Empty; string XNomor = string.Empty; string Hari = string.Empty;
            object CodeId = e.NewValues["EmployeeNo"];
            string cNIK = Convert.ToString(e.NewValues["AbsenteeismNo"]);
            string dTanggal = Convert.ToString(e.NewValues["Tanggal"]);
            DateTime dTgl = DateTime.Parse(dTanggal.ToString());

            int mm = dTgl.Month;
            int yy = dTgl.Year;
            int dd = dTgl.Day;
            tahun = yy.ToString();
            if (dd < 10)
            {
                Hari = "0" + dd.ToString();
            }
            else
            {
                Hari = dd.ToString();
            }
            if (mm < 10)
            {
                bulan = "0" + mm.ToString();
            }
            else
            {
                bulan = mm.ToString();
            }
            string xTgl = tahun + '-' + bulan + '-' + Hari;
            DateTime xTanggal = DateTime.Parse(xTgl.ToString());

            string fcShiftCode = Convert.ToString(e.NewValues["ShiftCode"]);
            string fcShifTyp = Convert.ToString(e.NewValues["ShiftType"]);
            string cDateIn = Convert.ToString(e.NewValues["DateIn"]);
            string cDateOut = Convert.ToString(e.NewValues["DateOut"]);
            string cKodeAbsent = Convert.ToString(e.NewValues["AbsentCode"]);
            // DateTime dTgl = DateTime.Parse(fcTanggal.ToString());

            using (SqlConnection con = new SqlConnection(conString))
            {
                // @EmpNo AND AbsenteeismNo = @NIK AND TransactionDate = @dTanggal
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_Update_Employee_Presensi", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 70200;
                cmd.Parameters.AddWithValue("@EmpNo", CodeId);
                cmd.Parameters.AddWithValue("@NIK", cNIK);
                cmd.Parameters.AddWithValue("@dTanggal", xTgl);
                cmd.Parameters.AddWithValue("@cKode", cKodeAbsent);
                cmd.Parameters.AddWithValue("@cKeter", "Update");

                cmd.Parameters.AddWithValue("@Usr", Session["User"]);
                cmd.Parameters.AddWithValue("@Jam", DateTime.Now);

                cmd.ExecuteNonQuery();
                con.Close();
            }
            e.Cancel = true;
            gvAbsent.CancelEdit();
        }
        protected void gvAbsent_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            ASPxGridView Grid = (ASPxGridView)sender;
            string keyValue = Grid.GetRowValues(e.VisibleIndex, "EmployeeNo").ToString();
            Session["Bukti"] = keyValue;

            gvAbsent.DataBind();
        }
        protected void cbEmp_SelectedIndexChanged(object sender, EventArgs e)
        {
            string cNIP = cbEmp.SelectedItem.Value.ToString();
            Session["NIP"] = cbEmp.SelectedItem.Value.ToString();
            // cari-----------------------------------------------------------------------------------------------------------------------------------
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_CR_Employee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cNIP", Session["NIP"]);

                SqlDataReader dr = cmd.ExecuteReader();
                dr.Read();
                if (dr.HasRows)
                {
                    Session["NIK"] = dr["AbsenteeismNo"].ToString();
                    Session["DeptCode"] = dr["Level4Code"].ToString();
                    Session["JbtnCode"] = dr["PositionCode"].ToString();
                    Session["GradeCode"] = dr["GradeCode"].ToString();
                }
                con.Close();
            }
            //            TimeIn.Focus();
        }
        protected void cbAbsent_SelectedIndexChanged(object sender, EventArgs e)
        {
            EdNotes.Focus();
        }
        protected void btnSaveRecord_Click(object sender, EventArgs e)
        {
            DateTime dTgl = DateTime.Parse(EdTanggal.Value.ToString());
            string cKode = string.Empty;
            string cNIP = cbEmp.SelectedItem.Value.ToString();
            string cNIK = Session["NIK"].ToString();
            string JamIN = string.Empty; string JamOut = string.Empty;
            if (cbAbsent.Value != null)
            {
                cKode = cbAbsent.SelectedItem.Value.ToString();
            }
            JamIN = "00:00:00"; JamOut = "00:00:00";
            if (TimeIn.Value != null)
            {
                JamIN = TimeIn.Value.ToString();
            }
            if (TimeOut.Value != null)
            {
                JamOut = TimeOut.Value.ToString();
            }

            using (SqlConnection con = new SqlConnection(conString))
            {
                // --------------------------- Insert Members via SP ----------------------
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_Insert_Employee_Presensi", con);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpNo", cNIP);
                cmd.Parameters.AddWithValue("@NIK", cNIK);
                cmd.Parameters.AddWithValue("@dTanggal", dTgl);
                cmd.Parameters.AddWithValue("@Masuk", JamIN);
                cmd.Parameters.AddWithValue("@Keluar", JamOut);
                cmd.Parameters.AddWithValue("@cKode", cKode);
                cmd.Parameters.AddWithValue("@cKeter", EdNotes.Text);

                cmd.Parameters.AddWithValue("@Usr", Session["User"]);
                cmd.Parameters.AddWithValue("@Jam", DateTime.Now);
                cmd.CommandTimeout = 70200;
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Response.Redirect("~/EmpAttendant.aspx");
        }
        protected void btnCloseRecord_Click(object sender, EventArgs e)
        {
            // POPEntry.ShowOnPageLoad = false;
            // gvAbsent.DataBind();
            Response.Redirect("~/EmpAttendant.aspx");
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Session["mForm"] = "Input";
            ModalInput.Visible = true;
        }



    }
}