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
    public partial class Capture : System.Web.UI.Page
    {
        string conString = ConfigurationManager.ConnectionStrings["HRConnection"].ConnectionString;

        public string oPeriode = string.Empty, cStatus = string.Empty, cPeriod = string.Empty, mPeriode = string.Empty;
        private DateTime dTgl1 = DateTime.Parse(DateTime.Now.ToString());
        private DateTime dTgl2 = DateTime.Parse(DateTime.Now.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Inits();
                // Cari Tanggal Awal
                string isiTgl1 = Session["Tgl1"].ToString();
                string isiTgl2 = Session["Tgl2"].ToString();
                dTgl1 = DateTime.Parse(isiTgl1.ToString());
                dTgl2 = DateTime.Parse(isiTgl2.ToString());
                oPeriode = Session["VPeriode"].ToString();
                cmbPeriode.Text = oPeriode;
                BukaData();
                gvCapture.DataBind();
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
        protected void BukaData()
        {
            List<string> result = new List<string>();
            //------------ Check -----------------
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT mp,keterangan,ms " +
                                                "FROM mPeriode  WITH (NOLOCK) " +
                                                "WHERE mp is not null  Order By mp ", con);
                //"WHERE mp = @cPeriod ", con);
                cmd.CommandType = CommandType.Text;
                cmd.CommandTimeout = 70200;
                //  cmd.Parameters.AddWithValue("@cPeriod", Session["VPeriode"]);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        for (int i = 0; i < dr.FieldCount; i++)
                        {
                            result.Add(dr[i].ToString());
                        }
                    }
                }
                if (result.Count > 0)
                {
                    oPeriode = result[0];
                    cStatus = result[2];
                }
                cmbPeriode.DataSource = dr;
                cmbPeriode.DataBind();
                con.Close();
            }
        }
        protected void gvCapture_DataBinding(object sender, EventArgs e)
        {
            gvCapture.DataSource = GetDataCapture();
        }
        protected DataTable GetDataCapture()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_EmployeeTimeCapture", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@dTgl1", dTgl1);
                cmd.Parameters.AddWithValue("@dTgl2", dTgl2);
                cmd.CommandTimeout = 70200;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                con.Close();
            }
            return dt;
        }
        protected void UpdatePanel_Unload(object sender, EventArgs e)
        {
            MethodInfo methodInfo = typeof(ScriptManager).GetMethods(BindingFlags.NonPublic | BindingFlags.Instance)
                .Where(i => i.Name.Equals("System.Web.UI.IScriptManagerInternal.RegisterUpdatePanel")).First();
            methodInfo.Invoke(ScriptManager.GetCurrent(Page),
                new object[] { sender as UpdatePanel });
        }
        protected void btnToPDF_Click(object sender, EventArgs e)
        {
            this.ASPxGridViewExporter.GridView.Columns[0].Visible = true;
            this.ASPxGridViewExporter.WritePdfToResponse();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Done...');", true);
        }
        protected void btnToExcel_Click(object sender, EventArgs e)
        {
            this.ASPxGridViewExporter.GridView.Columns[0].Visible = true;
            this.ASPxGridViewExporter.WriteXlsToResponse();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Done...');", true);
        }
        protected void btnGetCapture_Click(object sender, EventArgs e)
        {
            string apa = FileUpload.FileName;
            string fileNama = System.IO.Path.GetFileName(FileUpload.PostedFile.FileName);
            //  string Simpan = FileUpload.PostedFile.SaveAs(Server.MapPath("~/Uploads/" + fileNama));
            string nama = Server.MapPath(FileUpload.FileName);
            string NamaFile = string.Empty;
            // Lok = Session["mCode"].ToString();
            HttpPostedFile file = FileUpload.PostedFile;
            long sizeInKilobytes = file.ContentLength / 1024;
            string sizeText = sizeInKilobytes.ToString() + " KB";
            if ((FileUpload.PostedFile != null) && (file.ContentLength > 0))
            {
                string str = FileUpload.FileName;
                string fileName2 = Path.GetFileName(FileUpload.FileName);
                fileNama = Path.Combine(Server.MapPath("~/Uploads/Text/"), fileName2); // Ganti "~/uploads/" dengan path yang sesuai
                FileUpload.SaveAs(fileNama);
                string directoryPath = Path.GetDirectoryName(fileNama);

                string codeFilePath = Assembly.GetExecutingAssembly().Location;
                string codeDirectory = System.IO.Path.GetDirectoryName(codeFilePath);
                FileUpload.PostedFile.SaveAs(Server.MapPath("~/Uploads/Text/" + str));
                string ext = Path.GetExtension(FileUpload.PostedFile.FileName);
                NamaFile = Path.GetFileName(FileUpload.PostedFile.FileName);
                NamaFile = "~/Uploads/Text" + NamaFile;
                string Image = "~/Uploads/Text/" + str.ToString();
                int iFileSize = file.ContentLength;
                if (iFileSize > 4194304)  // 4MB
                {
                    // File exceeds the file maximum size
                    Label1.Text = "File Big Longer : ";
                    Label1.ForeColor = System.Drawing.Color.ForestGreen;
                    return;
                }
                else
                {
                    Label1.Text = "File Uploaded: " + FileUpload.FileName;
                    Label1.ForeColor = System.Drawing.Color.ForestGreen;
                }
            }
            else
            {
                Label1.Text = "Please Upload, No File Uploaded.";
                Label1.ForeColor = System.Drawing.Color.Red;
            }
            string FileDir = Path.GetDirectoryName(FileUpload.FileName);
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_Employee_Capture", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cFileTxt", fileNama);
                cmd.CommandTimeout = 70200;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                gvCapture.DataSource = dt;
                gvCapture.DataBind();
                con.Close();
            }
        }
        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Default.aspx");
        }
        protected void cmbPeriode_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
      
    }
}