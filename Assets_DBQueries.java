package com.gen.cms.assets.beans;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;

import com.gen.cms.exceptions.CmsGeneralException;
import com.gen.cms.exceptions.CmsNamingException;
import com.gen.cms.exceptions.CmsSQLException;
import com.gen.cms.util.DateManager;
import java.util.*;
public class Assets_DBQueries {
	
	public String BrowserVersion(String Information)
	{
		 String browserversion = "";
         String browser = Information  ;
         if(browser.contains("MSIE")){
             String subsString = browser.substring( browser.indexOf("MSIE"));
             String Info[] = (subsString.split(";")[0]).split(" ");
             browserversion = Info[1];
          }
         System.out.println("Broqser version "+browserversion);
         return browserversion;
	}
	
	public static boolean addAssets(AssetsMasterVal as)
	{
		DateManager dm=new DateManager();
		String dat=dm.getCurrentDate();//mm/dd/yyyy
		String tm=dm.getCurrentTime();//hh:mm:ss
		boolean flag=false;
		if (flag==false)
		{
			AssetsDAO dao=new AssetsDAO();
			System.out.print("In Insert query");
			String sql="insert into assets_main_category (main_category_name, main_short, crated_on, create_at, created_by) " +
				"values('"+as.getCate()+"','"+as.getShCat()+"','"+dat+"','"+tm+"','"+as.getUser_id()+"')";
			flag=dao.insert(sql);
			System.out.println("Inserted Query sucssful");
		}
		return flag;
	}
	
	
	public static boolean addSaleSrap(String user_name, String reg_id, String Aname, String ARefNo, String bDate, String BNumb, String SName,
			String PDate, String amnt, String Dep, String unit, String option, String rev, String buyer, String Reason, String file, String proc_id,
			String HodShName)
	{
		DateManager dm=new DateManager();
		String dat=dm.getCurrentDate();//mm/dd/yyyy
		String tm=dm.getCurrentTime();//hh:mm:ss
		AssetsDAO dao=new AssetsDAO();
		int status=5;
		String comment="";
		boolean flag1, flag;
			System.out.print("In Insert query");
			String sql1="insert into ASSETS_SALE_SCRAP (ASSETS_NAME, REF_NO, BILL_DATE, BILL_NO, SUPPLIER_NAME, P_DATE, AMOUNT, DEPARTMENT, UNIT, " +
					"SALE_SCRAP, REVENUE, BUYER_DETAIL, REASON, FILE_NAME, CREATED_BY, CREATED_ON, CREATED_AT, old_asset_reg, reject_comment, status, proc_ms_id, hodShname )" +
					"values('"+Aname+"','"+ARefNo+"','"+bDate+"','"+BNumb+"','"+SName+"','"+PDate+"','"+amnt+"','"+Dep+"','"+unit+"','"+option+"'," +
							"'"+rev+"','"+buyer+"','"+Reason+"','"+file+"','"+user_name+"','"+dat+"','"+tm+"','"+reg_id+"','"+comment+"','"+status+"','"+proc_id+"','"+HodShName+"')";
			System.out.println("SQL query of sal scrap "+sql1);
			flag=dao.insert(sql1);
			if(flag==true)
			{
				String sql="update assets_register set status='"+status+"' where asset_reg='"+reg_id+"'";
				System.out.println("Update SQL sale scrap "+sql);
				flag1=dao.insert(sql);
				System.out.println("flag sale scrap update "+flag1);
			}
		return flag;
	}
	
	public static ArrayList HODShortNames(String mst_id)
	{
		DateManager dm=new DateManager();
		String dat=dm.getCurrentDate();//mm/dd/yyyy
		String tm=dm.getCurrentTime();//hh:mm:ss
		ArrayList ar2=new ArrayList();
		System.out.println("Prog Mst Id "+mst_id+" length ");
		boolean flag=false;
		AssetsDAO dao=new AssetsDAO();
		String sql="select batch_mst_id from adm_batch_master where batch_mst_curr='"+1+"'";
		System.out.println("SQL "+sql);
		ArrayList ar=new ArrayList();
		try {
			ar = dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String bt_mst_id=ar.toString().replace("[", "").replace("]", "");
		System.out.println("Array value at position in "+bt_mst_id);
		
		String sql1="select admsn_fac_id from director_assign_coordinator where prog_mst_id='"+mst_id+"' and batch_mst_id='"+bt_mst_id+"' and co_type='"+1+"' and co_status='"+1+"' and co_acpt_status='"+2+"'";
		System.out.println("SQL "+sql1);
		ArrayList ar1=new ArrayList();
		try {
			ar1 = dao.select(sql1);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String tr_hod_id = ar1.toString().replace("[", "").replace("]", "");
		System.out.println("Transfer hod department id "+tr_hod_id);
		
		//new query
		String sql2="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+tr_hod_id+"'";
		System.out.println("SQL "+sql2);
		try {
			ar2 = dao.select(sql2);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String tr_fac_sh_name=ar2.toString().replace("[", "").replace("]", "");
		System.out.println("sh_name "+tr_fac_sh_name);
		return ar2;
	}
	
	public static boolean addTransfer(Dictionary dict, String key[])
	{
		DateManager dm=new DateManager();
		String dat=dm.getCurrentDate();//mm/dd/yyyy
		String tm=dm.getCurrentTime();//hh:mm:ss
		
		System.out.println("Prog Mst Id "+dict.get("prog_ms")+" length "+dict.size());
		boolean flag=false;
		AssetsDAO dao=new AssetsDAO();
		String sql="select batch_mst_id from adm_batch_master where batch_mst_curr='"+1+"'";
		ArrayList ar=new ArrayList();
		try {
			ar = dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String bt_mst_id=ar.toString().replace("[", "").replace("]", "");
		System.out.println("Array value at position in "+bt_mst_id);
		
		String sql1="select admsn_fac_id from director_assign_coordinator where prog_mst_id='"+dict.get("tr_dep_id")+"' and batch_mst_id='"+bt_mst_id+"' and co_type='"+1+"' and co_status='"+1+"' and co_acpt_status='"+2+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = dao.select(sql1);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String tr_hod_id = ar1.toString().replace("[", "").replace("]", "");
		System.out.println("Transfer hod department id "+tr_hod_id);
		
		String sql5="select prog_mst_id from director_assign_coordinator where prog_mst_id='"+dict.get("tr_dep_id")+"' and batch_mst_id='"+bt_mst_id+"' and co_type='"+1+"' and co_status='"+1+"' and co_acpt_status='"+2+"'";
		ArrayList ar5=new ArrayList();
		try {
			ar5 = dao.select(sql5);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String tran_id = ar5.toString().replace("[", "").replace("]", "");
		System.out.println("Transfer hod department id "+tran_id);
		//new query
		String sql2="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+tr_hod_id+"'";
		ArrayList ar2=new ArrayList();
		try {
			ar2 = dao.select(sql2);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String tr_fac_sh_name=ar2.toString().replace("[", "").replace("]", "");
		System.out.println("Short name of hod "+tr_fac_sh_name);
		String tr_app="0";
		String cur_app="0";
		String com="";
		String sts_by="";
		String sts_on="";
		String sts_at="";
		String sql3="insert into Assets_Transfer (assets_reg, main_cat, sub_cat, entry_date, descript, bill_no, bill_date, sup_name, Quantity, amount, " +
				"ref_id, ref_no, cur_proc_mci_id, cur_Department, unit, transfer_unit, transfer_dep, trans_dep_hod, trans_dep_hodsh_name, trans_hod_appr," +
				"trans_prog_mst_id, created_by, created_at, created_on, cur_hod_Appr_status, main_name, sub_name, comments, status_by, status_on," +
				"status_at, tr_status, trans_dep_proc_id) values('"+dict.get("reg_id")+"','"+dict.get("m_id")+"','"+dict.get("s_id")+"','"+dict.get("e_date")+"','"+dict.get("descript")+"'," +
				"'"+dict.get("b_no")+"','"+dict.get("b_date")+"','"+dict.get("s_name")+"','"+dict.get("quant")+"','"+dict.get("amount")+"'," +
				"'"+dict.get("ref_id")+"','"+dict.get("ref_no")+"','"+dict.get("prog_ms")+"','"+dict.get("dep")+"','"+dict.get("unit")+"'," +
				"'"+dict.get("tr_unit_sname")+"','"+dict.get("tr_dep_sname")+"','"+tr_hod_id+"','"+tr_fac_sh_name+"','"+tr_app+"','"+dict.get("tr_dep_id")+"'," +
				"'"+dict.get("email")+"','"+tm+"','"+dat+"','"+cur_app+"','"+dict.get("m_name")+"','"+dict.get("s_name")+"','"+com+"','"+sts_by+"','"+dat+"','"+tm+"','"+1+"','"+tran_id+"')";
		System.out.println("Assets transfer SQL query "+sql3);
		flag=dao.insert(sql3);
		if(flag==true)
		{
			String sql4="update assets_register set status='"+7+"' where asset_reg='"+dict.get("reg_id")+"'";
			boolean fl=dao.insert(sql4);
			System.out.println("Updated value "+fl);
		}
		System.out.println("Transfer value insert or no "+flag);
		
		return flag;
	}
	
	public static boolean addSubAssets(Sub_Cat_GS acg)
	{
		DateManager dm=new DateManager();
		String dat=dm.getCurrentDate();//mm/dd/yyyy
		String tm=dm.getCurrentTime();//hh:mm:ss
		boolean flag=false;
		if(flag==false)
		{
			AssetsDAO dao=new AssetsDAO();
			System.out.println("In Sub assets insert");
			String sql="insert into assets_sub_category (MAIN_CAT_ID, SUB_CAT_NAME, SUB_CAT_SHORT_NAME, sub_crated_on, sub_create_at, sub_created_by) " +
			"values('"+acg.getMain_cat()+"','"+acg.getSub_cat()+"','"+acg.getSub_cat_short()+"','"+dat+"','"+tm+"','"+acg.getUser_id()+"')";
			flag=dao.insert(sql);
			System.out.println("Inserted sucessfully");
		}
		return flag;
	}
	
	public static boolean addRegister(AssetsMasterVal acg, String sub_name, String main_name, String location, String sngl_amnt, String entry_by, String sup_number, String warranty, String hod_shname, File img, String file_name, String system_path)
	{
		DateManager dm=new DateManager();
		AssetsDAO dao=new AssetsDAO();
		String dat=dm.getCurrentDate();//mm/dd/yyyy
		String tm=dm.getCurrentTime();//hh:mm:ss
		FileInputStream fir=null;
		PreparedStatement ps = null;
		int fileLength = 0;

		String cmnt="";
		int st=1;
		String billDate=dm.getDBDate(""+acg.getBill_dt());
		boolean flag=false;
		if(flag==false)
		{
			System.out.println("In Register value insert");
			String sql=
				"insert into Assets_Register (main_cat, sub_cat, entry_date, descrip, bill_no, bill_date, supplier_name, quantity, " +
				"amount,ref_id,ref_no, proc_msi_id, department, unit, created_by, created_at, created_on, status, main_name, sub_name, comments," +
				" OLD_ASSETS_REG_NO, TRANSFER_STATUS, SCRAPSALE_STATUS,newlocation,single_amnt, entry_by, supl_number, warranty, status_by, file_name, system_file_path) " +
			"values('"+acg.getMain_cat()+"','"+acg.getSub_cat()+"','"+acg.geteDate()+"','"+acg.getDescr()+"','"+acg.getBill_no()+"'," +
					"'"+billDate+"','"+acg.getSuppl()+"','"+acg.getQuant()+"','"+acg.getAmnt()+"','"+acg.getRef_id()+"','"+acg.getRef_no()+"'," +
					"'"+acg.getPgm_m_id()+"','"+acg.getDep()+"','"+acg.getUnit()+"','"+acg.getUser_id()+"','"+tm+"','"+dat+"','"+st+"'," +
					"'"+main_name+"','"+sub_name+"','"+cmnt+"','"+0+"','"+0+"','"+0+"','"+location+"','"+sngl_amnt+"','"+entry_by+"','"+sup_number+"','"+warranty+"','"+hod_shname.toUpperCase()+"'," +
							"'"+file_name+"','"+system_path+"')";
			System.out.println("SqL value "+sql);
			flag=dao.insert(sql);
			System.out.println("Inserted sucessfully");
		}
		return flag;
	}
	
	public static boolean updateAssetsRegisterFilePath(String file_path, String ref_no)
	{
		boolean flag=false;
		int status=3;
		AssetsDAO dao=new AssetsDAO();
		System.out.println();
		String sql="update assets_register set file_path='"+file_path+"' where ref_no='"+ref_no+"'";
		System.out.println("Update SQL "+sql);
		flag=dao.insert(sql);
		System.out.println("flag "+flag);
		return flag;
	}
	
	public static boolean updateAssets(String status, String comment, String id, String user_id)
	{
		boolean flag=false;
		AssetsDAO dao=new AssetsDAO();
		DateManager dm=new DateManager();
		String dat=dm.getCurrentDate();//mm/dd/yyyy
		String tm=dm.getCurrentTime();//hh:mm:ss
		System.out.println();
		ArrayList ar=new ArrayList();
		String sql1="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+user_id+"'";
		System.out.println("SQL query value "+sql1);
		try {
			ar=dao.select(sql1);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String created=""+ar.get(0).toString().replace("[", "").replace("]", ""); 
		String created_by=created.toUpperCase();
		System.out.println("Cread by short name "+created_by);
		String sql="update assets_register set status='"+status+"', comments='"+comment+"', status_by='"+created_by+"', status_on='"+dat+"', status_at='"+tm+"' where asset_reg='"+id+"'";
		System.out.println("Update SQL "+sql);
		flag=dao.insert(sql);
		System.out.println("flag "+flag);
		return flag;
	}
	
	public static boolean updateAssetsStatus(String id)
	{
		boolean flag=false;
		int status=3;
		AssetsDAO dao=new AssetsDAO();
		System.out.println();
		String sql="update assets_register set status='"+status+"' where asset_reg='"+id+"'";
		System.out.println("Update SQL "+sql);
		flag=dao.insert(sql);
		System.out.println("flag "+flag);
		return flag;
	}
	
	public static boolean updateAssetsSSStatus(String req_id, String status, String cmnt)
	{
		boolean flag=false, flag1;
		AssetsDAO dao=new AssetsDAO();
		String sql2="update assets_sale_scrap set hod_status='"+status+"', hod_comment='"+cmnt+"' where req_id='"+req_id+"'";
		System.out.println("Updated "+sql2);
		flag1=dao.insert(sql2);
		if(flag1==true)
		{
			System.out.println("in if ture");
			sql2="update assets_sale_scrap_ref_tab set hod_status='"+status+"', hod_comment='"+cmnt+"' where req_id='"+req_id+"'";
			System.out.println("Updated "+sql2);
			flag1=dao.insert(sql2);
		}
		System.out.println("value deleted is "+flag1);
		return flag1;
	}
	
	public static boolean updateAssetsSSStatusUp(String req_id, String status, String cmnt)
	{
		boolean flag=false, flag1;
		AssetsDAO dao=new AssetsDAO();
		String sql2="update assets_sale_scrap set hod_status='"+status+"' where req_id='"+req_id+"'";
		System.out.println("Updated "+sql2);
		flag1=dao.insert(sql2);
		if(flag1==true)
		{
			System.out.println("in if ture");
			sql2="update assets_sale_scrap_ref_tab set hod_status='"+status+"' where req_id='"+req_id+"'";
			System.out.println("Updated "+sql2);
			flag1=dao.insert(sql2);
		}
		System.out.println("value deleted is "+flag1);
		return flag1;
	}
	
	public static boolean updateAssetsSSStatusMTUP(String req_id, String status, String cmnt)
	{
		boolean flag=false, flag1;
		AssetsDAO dao=new AssetsDAO();
		String sql2="update assets_sale_scrap set mt_status='"+status+"', mt_comments='"+cmnt+"' where req_id='"+req_id+"'";
		System.out.println("Updated "+sql2);
		flag1=dao.insert(sql2);
		if(flag1==true)
		{
			System.out.println("in if ture");
			sql2="update assets_sale_scrap_ref_tab set mt_status='"+status+"', mt_comments='"+cmnt+"' where req_id='"+req_id+"'";
			System.out.println("Updated "+sql2);
			flag1=dao.insert(sql2);
		}
		System.out.println("value deleted is "+flag1);
		return flag1;
	}
	
	public static boolean updateAssetsSSStatusMTUPUp(String req_id, String status, String cmnt)
	{
		boolean flag=false, flag1;
		AssetsDAO dao=new AssetsDAO();
		String sql2="update assets_sale_scrap set mt_status='"+status+"' where req_id='"+req_id+"'";
		System.out.println("Updated "+sql2);
		flag1=dao.insert(sql2);
		if(flag1==true)
		{
			System.out.println("in if ture");
			sql2="update assets_sale_scrap_ref_tab set mt_status='"+status+"' where req_id='"+req_id+"'";
			System.out.println("Updated "+sql2);
			flag1=dao.insert(sql2);
		}
		System.out.println("value deleted is "+flag1);
		return flag1;
	}
	
	
	public static ArrayList UpdateAssetRegSaleS(String req_id)
	{
		ArrayList ar=new ArrayList();
		AssetsDAO dao=new AssetsDAO();
		String sql2="select sub_register from assets_sale_scrap_ref_tab where req_id='"+req_id+"'";
		System.out.println("Select "+sql2);
		try {
			ar=dao.select(sql2);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("value deleted is "+ar);
		return ar;
	}
	

	public static ArrayList SelectBillPath(String req_id)
	{
		ArrayList ar=new ArrayList();
		AssetsDAO dao=new AssetsDAO();
		String sql2="select file_path, file_name from assets_register where asset_reg='"+req_id+"'";
		System.out.println("Select "+sql2);
		try {
			ar=dao.select(sql2);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("value deleted is "+ar);
		return ar;
	}
	
	public static boolean SaleScrapFinal(String asset_reg, String req_id)
	{
		boolean flag=false, flag1;
		AssetsDAO dao=new AssetsDAO();
		String sql2="update assets_register set STATUS='"+5+"', SCRAPSALE_STATUS='"+1+"' where ASSET_REG='"+asset_reg+"'";
		System.out.println("Updated "+sql2);
		flag1=dao.insert(sql2);
		if(flag1==true)
		{
			System.out.println("in if ture");
			sql2="update assets_sale_scrap_ref_tab set hod_status='"+3+"', mt_status='"+3+"' where req_id='"+req_id+"'";
			System.out.println("Updated "+sql2);
			flag1=dao.insert(sql2);
			System.out.println("in if ture");
			sql2="update assets_sale_scrap set hod_status='"+3+"', mt_status='"+3+"' where req_id='"+req_id+"'";
			System.out.println("Updated "+sql2);
			flag1=dao.insert(sql2);
		}
		System.out.println("value deleted is "+flag1);
		return flag1;
	}
	
	public static boolean updateAssetsSSStatusMT(String req_id, String status, String cmnt)
	{
		boolean flag=false, flag1;
		AssetsDAO dao=new AssetsDAO();
		String sql2="update assets_sale_scrap set mt_status='"+status+"', mt_comments='"+cmnt+"' where req_id='"+req_id+"'";
		System.out.println("Updated "+sql2);
		flag1=dao.insert(sql2);
		if(flag1==true)
		{
			System.out.println("in if ture");
			sql2="update assets_sale_scrap_ref_tab set mt_status='"+status+"', mt_comments='"+cmnt+"' where req_id='"+req_id+"'";
			System.out.println("Updated "+sql2);
			flag1=dao.insert(sql2);
		}
		System.out.println("value deleted is "+flag1);
		return flag1;
	}
	
	public static boolean updateAssetsSaleScrap(String reg_id,String comment, String status, String user_id)
	{
		boolean flag=false;
		AssetsDAO dao=new AssetsDAO();
		System.out.println();
		ArrayList ar=new ArrayList();
		String sql1="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+user_id+"'";
		System.out.println("SQL query value "+sql1);
		try {
			ar=dao.select(sql1);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String created=""+ar.get(0).toString().replace("[", "").replace("]", ""); 
		String created_by=created.toUpperCase();
		String sql="update assets_sale_scrap set reject_comment='"+comment+"', status='"+status+"', hodshname='"+created+"' where old_asset_reg='"+reg_id+"' and created_by='"+user_id+"'";
		System.out.println("Update SQL "+sql);
		flag=dao.insert(sql);
		System.out.println("flag "+flag);
		return flag;
	}
	
	public static boolean updateAssetsReg(String descrp, String Bill_no,String Supplier_name, String Quantity, String amount,String as_id)
	{
		boolean flag=false;
		AssetsDAO ad=new AssetsDAO();
		int stat=0;
		System.out.println("In update Assets Register");
		String sql="update assets_register set descrip='"+descrp+"', bill_no='"+Bill_no+"', supplier_name='"+Supplier_name+"', quantity='"+Quantity+"', amount='"+amount+"', status='"+stat+"' where asset_reg='"+as_id+"'";
		flag=ad.insert(sql);
		System.out.println("Assets update or no "+flag);
		System.out.println("Sql update query "+sql);
		return flag;
	}
	
	public static boolean updateAssetsSS(String rev, String vendr, String reason1, String file, String reg_id, String old_reg)
	{
		boolean flag=false;
		AssetsDAO ad=new AssetsDAO();
		int stat=5;
		System.out.println("In update Assets Register");
		String sql="update assets_sale_scrap set revenue='"+rev+"', buyer_detail='"+vendr+"', reason='"+reason1+"', file_name='"+file+"', status='"+stat+"' where assets_num='"+reg_id+"'";
		flag=ad.insert(sql);
		if(flag==true)
		{
			String sql2="update assets_register set status='"+5+"' where asset_reg='"+old_reg+"'";
			flag=ad.insert(sql2);
			System.out.println("Assets register value "+sql2);
		}
		System.out.println("Assets update or no "+flag);
		System.out.println("Sql update query "+sql);
		return flag;
	}
	
	public static boolean insertAssetsStatus(String asset_reg, String sub_name, String status, String comments, String user_id)
	{
		DateManager db=new DateManager();
		AssetsDAO as=new AssetsDAO();
		String tm=db.getCurrentTime();
		String dt=db.getCurrentDate();
		ArrayList ar=new ArrayList();
		String sql1="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+user_id+"'";
		System.out.println("SQL query value "+sql1);
		try {
			ar=as.select(sql1);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String created=""+ar.get(0).toString().replace("[", "").replace("]", ""); 
		String created_by=created.toUpperCase();
		System.out.println("Cread by short name "+created_by);
		boolean flag;
			String sql="insert into assets_status(assets_reg_id,sub_name,status,comments,create_by, created_at, created_on)" +
					"values('"+asset_reg+"','"+sub_name+"','"+status+"','"+comments+"','"+user_id+"','"+tm+"','"+dt+"')";
			System.out.println("In insert assets status "+sql);
			flag=as.insert(sql);
		return flag;
	}
	
	
	public static boolean updateAssetsSSStatus(String asset_reg, String sub_name, String status, String comments, String user_id)
	{
		DateManager db=new DateManager();
		AssetsDAO as=new AssetsDAO();
		String tm=db.getCurrentTime();
		String dt=db.getCurrentDate();
		ArrayList ar=new ArrayList();
		String sql1="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+user_id+"'";
		System.out.println("SQL query value "+sql1);
		try {
			ar=as.select(sql1);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String created=""+ar.get(0).toString().replace("[", "").replace("]", ""); 
		String created_by=created.toUpperCase();
		System.out.println("Cread by short name "+created_by);
		boolean flag;
			String sql="insert into assets_sale_scrap_status(sub_name, status, comments, olg_reg_no, created_by, created_on, created_at)" +
					"values('"+sub_name+"','"+status+"','"+comments+"','"+asset_reg+"','"+user_id+"','"+dt+"','"+tm+"')";
			System.out.println("In insert assets status "+sql);
			flag=as.insert(sql);
		return flag;
	}
	
	
	public  ArrayList selectMainCat()
	{
		AssetsDAO dao=new AssetsDAO();
		String sql="select * from assets_main_category";
		ArrayList ar=new ArrayList();
		try {
			ar=dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public static  ArrayList selectMainCat1()
	{
		AssetsDAO dao=new AssetsDAO();
		String sql="select * from assets_main_category";
		ArrayList ar=new ArrayList();
		try {
			ar=dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public ArrayList getMainAssetCategory(){
		ArrayList res=new ArrayList();
		AssetsDAO dao=new AssetsDAO();
		String sql="select * from assets_main_category";
		
		try {
			res=dao.select(sql);
			System.out.println("get assets_main_category "+res);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
		
		
	}
	
	public ArrayList select_sub_cat()
	{
		AssetsDAO dao=new AssetsDAO();
		String sql="select * from ASSETS_SUB_CATEGORY";
		ArrayList result = new ArrayList();
		try {
			try {
				result=dao.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Selected :" +result);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			System.out.println("In Exception 2");
			e.printStackTrace();
		}
		return result;
	}
	public static ArrayList select_sub_cat1()
	{
		AssetsDAO dao=new AssetsDAO();
		String sql="select * from ASSETS_SUB_CATEGORY";
		ArrayList result = new ArrayList();
		try {
			try {
				result=dao.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Selected :" +result);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			System.out.println("In Exception 2");
			e.printStackTrace();
		}
		return result;
		
	}
	
	
	public static ArrayList checkForExistingCategory(AssetsMasterVal cat){
		AssetsDAO dao=new AssetsDAO();
		ArrayList res=new ArrayList();
		String sql="select * from assets_main_category where main_category_name='"+cat.getCate()+"'or main_short='"+cat.getShCat()+"'";
		try {
			res=dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	public static ArrayList checkForExistingSubCategory(Sub_Cat_GS cat){
		AssetsDAO dao=new AssetsDAO();
		ArrayList res=new ArrayList();
		String sql="select * from assets_sub_category where sub_cat_name='"+cat.getSub_cat()+"'or sub_cat_short_name='"+cat.getSub_cat_short()+"'";
		try {
			res=dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	public static ArrayList fetchSubCatShortName(AssetsMasterVal cat){
		AssetsDAO dao=new AssetsDAO();
		ArrayList res=new ArrayList();
		String sql="select sub_cat_short_name from assets_sub_category where sub_category_id='"+cat.getSub_cat()+"'";
		try {
			res=dao.select(sql);
			System.out.println("Sub short name "+dao);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
public ArrayList selectSubName(long str)
	{
		AssetsDAO dao=new AssetsDAO();
		String sql="select * from assets_sub_category where main_cat_id = '"+str+"'";
		System.out.println("SQL : "+sql);
		ArrayList i=new ArrayList();
		try {
			i=dao.select(sql);
			System.out.println("Array list sub cat "+i);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;	
	}

public ArrayList SelectUnit()
{
	AssetsDAO dao=new AssetsDAO();
	String sql="select DISTINCT asset_unit_sh from adm_program_master";
	System.out.println("SQL : "+sql);
	ArrayList i=new ArrayList();
	try {
		i=dao.select(sql);
		System.out.println("Array list Unit "+i);
	} catch (CmsSQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsNamingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsGeneralException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return i;	
}

public ArrayList SelectDepartment(String unit)
{
	AssetsDAO dao=new AssetsDAO();
	String sql="select prog_mst_id, prog_mst_name, asset_dept_sh from adm_program_master where asset_unit_sh='"+unit+"'";
	System.out.println("SQL : "+sql);
	ArrayList i=new ArrayList();
	try {
		i=dao.select(sql);
		System.out.println("Array list Department "+i);
	} catch (CmsSQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsNamingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsGeneralException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return i;	
}

public ArrayList selectSubName1(String str)
{
	AssetsDAO dao=new AssetsDAO();
	String sql="select * from assets_sub_category where main_cat_id = '"+str+"'";
	System.out.println("SQL : "+sql);
	ArrayList i=new ArrayList();
	try {
		i=dao.select(sql);
		System.out.println("Array list sub cat "+i);
	} catch (CmsSQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsNamingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsGeneralException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return i;	
}

public ArrayList selectSubNameForAddAssets(String str, String sub_id)
{
	AssetsDAO dao=new AssetsDAO();
	String sql="select * from assets_sub_category where main_cat_id = '"+str+"' and sub_category_id='"+sub_id+"'";
	System.out.println("SQL : "+sql);
	ArrayList i=new ArrayList();
	try {
		i=dao.select(sql);
		System.out.println("Array list sub cat "+i);
	} catch (CmsSQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsNamingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (CmsGeneralException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return i;	
}

	public ArrayList selectRegisterData(String email, String sub_cat)
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList li=new ArrayList();
		ArrayList l2=new ArrayList();
		String sql="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		try {
			li=dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String proc_id=li.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("List prog_id Found is "+li.get(0));
		System.out.println("proc id found is "+proc_id);
		String sql2="select * from assets_register where status='"+1+"' and sub_cat='"+sub_cat+"' and proc_msi_id='"+proc_id+"'";
		System.out.println("SQL query"+sql2);
		try {
			l2=dao.select(sql2);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Category details "+l2);
		return l2;
	}
	
	public ArrayList selectDepartment()
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select prog_mst_id, prog_mst_name from adm_program_master";
		System.out.println("SQL = "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public ArrayList selectUnit()
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select DISTINCT asset_unit_sh from adm_program_master";
		System.out.println("SQL = "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public int sumAssetInUnit(String id)
	{
		System.out.println("In sumAssetInUnit ");
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select prog_mst_id from adm_program_master where asset_unit_sh='"+id+"'";
		System.out.println("SQL Sum of unit= "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int sum=0;
		ArrayList result=new ArrayList();
		for(int i=0;i<ar.size();i++)
		{
			ArrayList pr=(ArrayList)ar.get(i);
			System.out.println("Array unit = "+pr.get(0));
			for(int j=0;j<pr.size();j++)
			{
				System.out.println("Unit is "+pr.get(j));
				sql="select sum(status) from assets_register where proc_msi_id='"+pr.get(j)+"' and status='"+1+"'";
				try {
					result=dao.select(sql);
				} catch (CmsSQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsNamingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsGeneralException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("Result "+result);
				String str=result.toString().replace("[", "").replace("]", "");
				if(!str.equals("null"))
				{
					System.out.println("String result "+str);
					sum=sum+Integer.parseInt(str);
				}
				else
				{
					System.out.println("null "+str);
				}
			}
		}
		System.out.println("Sum of all number "+sum);
		return sum;
	}
	
	public ArrayList selectDepart(String dep)
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select prog_mst_id, prog_mst_sh_name from adm_program_master where asset_unit_sh='"+dep+"'";
		System.out.println("SQL = "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public ArrayList selectMainCategory(String dep)
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select CATEGORY_ID, MAIN_CATEGORY_NAME from ASSETS_MAIN_CATEGORY";
		System.out.println("SQL = "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public ArrayList selectSubCategory(String dep)
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select SUB_CATEGORY_ID, SUB_CAT_NAME from ASSETS_SUB_CATEGORY where MAIN_CAT_ID='"+dep+"'";
		System.out.println("SQL = "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public int sumAssetInDepart(String id)
	{
		System.out.println("In sumAssetInDepart ");
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		int sum=0;
		String sql="select sum(status) from assets_register where proc_msi_id='"+id+"' and status='"+1+"'";
		System.out.println("SQL Sum of unit= "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String str=ar.get(0).toString().replace("[", "").replace("]", "");
		if(!str.equals("null"))
		{
			sum=Integer.parseInt(str);
		}
		else{
			sum=0;
		}
		System.out.println("Sum of all number "+sum);
		return sum;
	}
	
	public int sumAssetInMainCat(String id, String main_cat)
	{
		System.out.println("In sumAssetInDepart ");
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		int sum=0;
		String sql="select sum(status) from assets_register where main_cat='"+main_cat+"' and proc_msi_id='"+id+"' and status='"+1+"'";
		System.out.println("SQL Sum of unit= "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String str=ar.get(0).toString().replace("[", "").replace("]", "");
		if(!str.equals("null"))
		{
			sum=Integer.parseInt(str);
		}
		else{
			sum=0;
		}
		System.out.println("Sum of all number "+sum);
		return sum;
	}
	
	public int sumAssetInSubCat(String id, String sub_cat, String proc)
	{
		System.out.println("In sumAssetInDepart ");
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		int sum=0;
		String sql="select sum(status) from assets_register where main_cat='"+id+"' and sub_cat='"+sub_cat+"' and proc_msi_id='"+proc+"' and status='"+1+"'";
		System.out.println("SQL Sum of unit= "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String str=ar.get(0).toString().replace("[", "").replace("]", "");
		if(!str.equals("null"))
		{
			sum=Integer.parseInt(str);
		}
		else{
			sum=0;
		}
		System.out.println("Sum of all number "+sum);
		return sum;
	}
	
	public ArrayList selectDepartmentShortName()
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select asset_dept_sh from adm_program_master";
		System.out.println("SQL = "+sql);
		try {
			ar=dao.select(sql);
			System.out.println("fetch value= "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	
	public ArrayList selectAllDataTrns(String mst_id) 
	{
		AssetsDAO dao=new AssetsDAO();
		ArrayList ar=new ArrayList();
		String sql="select prog_mst_id, prog_mst_name, asset_unit_sh, asset_dept_sh from adm_program_master where prog_mst_id='"+mst_id+"'";
		System.out.println("SQL value to fetch data "+sql);
		
		try {
			ar=dao.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Values founds are "+ar);
		return ar;
	}
	
	public ArrayList selectMainName(String str)
	{
		AssetsDAO dao=new AssetsDAO();
		String sql="select * from assets_main_category where category_id = '"+str+"'";
		System.out.println("SQL : "+sql);
		ArrayList i=new ArrayList();
		try {
			i=dao.select(sql);
			System.out.println("Array list main cat "+i);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;	
	}
	
	public static ArrayList getDepUserId(AssetsMasterVal amv){
		AssetsDAO dao=new AssetsDAO();
		ArrayList res=new ArrayList();
		String sql="select ADMSN_FAC_CURR_JOB_INFO.PROG_MST_ID, ASSET_UNIT_SH, ASSET_DEPT_SH from ADMSN_FAC_CURR_JOB_INFO inner join ADM_PROGRAM_MASTER on " +
				"ADMSN_FAC_CURR_JOB_INFO.PROG_MST_ID = ADM_PROGRAM_MASTER.PROG_MST_ID where ADMSN_FAC_CURR_JOB_INFO.admsn_fac_id='"+amv.getUser_id()+"'";
		try {
			try {
				res=dao.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("In fetch id method "+res);
		}  catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
/*	public ArrayList selectHODShName(String email)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		ArrayList ar1=new ArrayList();
		ArrayList ar2=new ArrayList();		
		String sql1="select batch_mst_id from adm_batch_master where batch_mst_curr='"+1+"'";
		System.out.println("Sql query found is "+sql1);
		try
		{
			ar1=ad.select(sql1);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String id="";
		id=ar1.get(0).toString().replace("[", "").replace("]", ""); //remove the left bracket;
		String sql2="select prog_mst_id from director_assign_coordinator where batch_mst_id='"+id+"' and co_type='"+1+"' and co_status='"+1+"' and co_acpt_status='"+2+"'" +
		"and admsn_fac_id='"+email+"'";
		System.out.println("value got from  director_assign_coordinator table is ="+sql2);
		try {
			ar2=ad.select(sql2);
			System.out.println("executed value is = "+ar2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		ArrayList ar3=new ArrayList();
		
		return ar2;
	}*/

	public ArrayList subCategoryName(String val)
	{
		System.out.println("In select sub category name ");
		AssetsDAO ad=new AssetsDAO();
		ArrayList subname=new ArrayList();
		String sql="select sub_cat_name from assets_sub_category where='"+val+"'";
		System.out.println("Queries "+sql );
		try {
			subname=ad.select(sql);
			System.out.println("Aftare executing query is "+subname);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return subname;
	}
	
	public ArrayList getRegisterAssetsDeta1(String email)
	{
		System.out.println("In get register assets data");
		AssetsDAO ad=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = ad.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		ArrayList arr1=new ArrayList();
		String sql="select * from assets_register where status='"+0+"' and created_by='"+str+"'";
		System.out.println("Sql queries "+sql);
		try {
			arr1=ad.select(sql);
			System.out.println("Query excuted "+arr1);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return arr1;
	}
	

	public static String getRef_id(AssetsMasterVal av)
	{
		AssetsDAO ad=new AssetsDAO();
		String ar="0";
		String sql="select max(ref_id) from assets_register where sub_cat='"+av.getSub_cat()+"' and department='"+av.getDep()+"' and unit='"+av.getUnit()+"'";
		System.out.println("query "+sql);
		try {
			ar=ad.selectText(sql);
			System.out.println("Get Ref Number "+ar);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ar;
	}
	
	public ArrayList getStatusVal(String email)
	{
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where created_by='"+email+"' and proc_msi_id='"+str+"' and not status='"+5+"' and not status='"+6+"' and not status='"+7+"' and not status='"+4+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	return ar;
	}
	
	
	public ArrayList getSaleScrapStatusVal(String email)
	{
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_sale_scrap where created_by='"+email+"' and proc_mst_id='"+str+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	return ar;
	}
	
	
	public ArrayList getSaleSrapStatus(String email)
	{
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where created_by='"+email+"' and proc_msi_id='"+str+"' and status='"+5+"' or status='"+4+"' or status='"+6+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	return ar;
	}
	
	public ArrayList selectAssetsRegisterData1(String as_reg_id){
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select proc_msi_id from assets_register where asset_reg='"+as_reg_id+"'";
		System.out.println("selectAssetsRegisterData query ="+sql);
		try {
			rs=ad.select(sql);
			System.out.println("select assets_reg "+rs);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public ArrayList selectAssetsRegisterData2(String as_reg_id){
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from assets_register where asset_reg='"+as_reg_id+"'";
		System.out.println("selectAssetsRegisterData2 query ="+sql);
		try {
			rs=ad.select(sql);
			System.out.println("select assets_reg "+rs);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public ArrayList selectReportAssetRegister(String email, String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where proc_msi_id='"+str+"' and sub_cat='"+s_id+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	public ArrayList selectReportAssetRegisterUnitWise(String s_id, String str)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		System.out.println("Department id "+str);
		String sql="select * from assets_register where proc_msi_id='"+str+"' and sub_cat='"+s_id+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	
	public ArrayList selectReportAssetRegisterTransfer(String email, String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where proc_msi_id='"+str+"' and sub_cat='"+s_id+"' and status='"+3+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	public ArrayList TRMainCatCheck(String email, String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where proc_msi_id='"+str+"' and MAIN_CAT='"+s_id+"' and status='"+3+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	public ArrayList AssetRegisterReporter(String email, String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where proc_msi_id='"+str+"' and sub_cat='"+s_id+"' and status='"+1+"' and created_by='"+email+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	public ArrayList AssetRegisterReporterMainCategory(String email, String m_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where proc_msi_id='"+str+"' and main_cat='"+m_id+"' and status='"+1+"' and created_by='"+email+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	public ArrayList SSMainCatCheck(String email, String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select * from assets_register where proc_msi_id='"+str+"' and MAIN_CAT='"+s_id+"' and status='"+5+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	public ArrayList SSDate(String email, String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select REQ_ID from ASSETS_SALE_SCRAP_REF_TAB where SUB_REGISTER='"+s_id+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select CREATED_ON from ASSETS_SALE_SCRAP where REQ_ID='"+str+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	
	public ArrayList TRDate(String email, String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select REQ_ID from ASSETS_TRANSFER_REF_TAB where SUB_REGISTER_NO='"+s_id+"'";
		System.out.println("Query "+sql2);
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
			System.out.println("data "+ar1);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select CREATED_ON from ASSETS_TRANSFER where REQ_ID='"+str+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
/*	public ArrayList Seearch(String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String query="select * from assets_register where created_by like'%"+s_id.toLowerCase()+"%'";
		System.out.println("Query "+query);
		ArrayList res=new ArrayList();
		try {
			res = ad.select(query);
			System.out.println("Result "+res);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}*/
	
	public ArrayList Seearch(String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String query1="select admsn_fac_id from admsn_faculty_info where lower(admsn_fac_fname) like'"+s_id.toLowerCase()+"%' or lower(admsn_fac_mname) like'"+s_id.toLowerCase()+"%' or lower(admsn_fac_lname) like'"+s_id.toLowerCase()+"%'";
		System.out.println("Id fetch query "+query1);
		ArrayList fac=new ArrayList();
		try {
			fac=ad.select(query1);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("Id found is "+fac);
		ArrayList res=new ArrayList();
		for(int i=0;i<fac.size();i++)
		{
			ArrayList id=(ArrayList)fac.get(i);
			System.out.println("Id = "+id);
			for(int j=0;j<id.size();j++)
			{
				System.out.println("Id = "+id.get(j));
				String query="select * from assets_register where created_by='"+id.get(j)+"'";
				try {
					ArrayList arr=ad.select(query);
					System.out.println("Array Value fetch is "+arr);
					if(!arr.isEmpty())
					{
						for(int k=0;k<arr.size();k++)
						{
							ArrayList re=(ArrayList)arr.get(k);
							System.out.println("Array result "+re.get(0));
							System.out.println("Array new data "+re);
							res.add(re);
						}
					}
				} catch (CmsSQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsNamingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsGeneralException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		System.out.println("Result found is "+res);
		return res;
	}
	
	public String FullNameAssoc(String email)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String query="select ADMSN_FAC_FNAME, admsn_fac_lname from admsn_faculty_info where ADMSN_FAC_ID='"+email+"'";
		System.out.println("Query "+query);
		ArrayList res=new ArrayList();
		try {
			res = ad.select(query);
			System.out.println("Result "+res);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String fullName="";
		for(int i=0;i<res.size();i++)
		{
			ArrayList fName=(ArrayList)res.get(i);
			String Name=""+fName.get(0);
			String Lname=""+fName.get(1);
			fullName=Name+" "+Lname;
		}
		System.out.println("Full name "+fullName);
		return fullName;
	}
		
	public ArrayList SearchDepart(String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String query="select prog_mst_id, prog_mst_sh_name from adm_program_master where asset_unit_sh like'%"+s_id.toUpperCase()+"%'";
		ArrayList res=new ArrayList();
		try {
			res = ad.select(query);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	public ArrayList MainNSubNSumAll(String s_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		System.out.println("Before main");
		String query="select category_id, main_category_name from ASSETS_MAIN_CATEGORY";
		System.out.println("Query  main "+query);
		ArrayList res=new ArrayList();
		try {
			res = ad.select(query);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("result main "+res);
		return res;
		
	}
	
	public ArrayList SubNameID(String s_id, String proc_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		System.out.println("Before sub");
		String query="select sub_category_id, sub_cat_name from assets_sub_category where main_cat_id='"+s_id+"'";
		System.out.println("Query  sub "+query);
		ArrayList res=new ArrayList();
		try {
			res = ad.select(query);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("result sub "+res);
		/*al.add(res);
		ArrayList res1=new ArrayList();
		for(int i=0;i<res.size();i++)
		{
			ArrayList arr=(ArrayList)res.get(i);
			System.out.println("Assets number id "+arr.get(0));
			String sql="select sum(ref_id) from assets_register where sub_cat='"+arr.get(0)+"' and proc_msi_id='"+proc_id+"' and status='"+1+"'";
			System.out.println("Select sum query "+sql);
			try {
				res1=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Select sum number is "+res1);
			al.add(res1);
		}*/
		System.out.println("Added to new array is "+res);
		return res;
	}
	
	public ArrayList SumOfsub(String s_id, String proc_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		System.out.println("Before sub");
		String sql="select sum(ref_id) from assets_register where sub_cat='"+s_id+"' and proc_msi_id='"+proc_id+"' and status='"+1+"'";
		System.out.println("Select sum query "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Added to new array is "+al);
		return al;
	}
	
	public ArrayList PrintMethod(String prog_id, String m_cat)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		System.out.println("Before sub");
		String sql="select * from assets_register where proc_msi_id='"+prog_id+"' and main_cat='"+m_cat+"'";
		System.out.println("Select fetch main category query "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Added to new array is "+al);
		return al;
	}
	
	public ArrayList DepartmentUnit(String email)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String str=""+ar1.get(0).toString().replace("[", "").replace("]", "");
		System.out.println("Department id "+str);
		String sql="select asset_unit_sh, asset_dept_sh from adm_program_master where prog_mst_id='"+str+"'";
		System.out.println("In Status select option "+sql);
		ArrayList ar=new ArrayList();
			try {
				ar=as.select(sql);
				System.out.println("Statis select option result "+ar);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println("Department Name "+ar);
		return ar;
	}
	
	
	
	public ArrayList DepartmentProg_MST_Id(String email)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select prog_mst_id from admsn_fac_curr_job_info where admsn_fac_id='"+email+"'";
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("Department Name "+ar1);
		return ar1;
	}
	
	public ArrayList TRDepRefNo(String id)
	{
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select DEPARTMENT, REF_NO from ASSETS_REGISTER where OLD_ASSETS_REG_NO='"+id+"'";
		System.out.println("Request ID  "+sql2);
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("request Name "+ar1);
		
		return ar1;
	}
	
	public ArrayList TrDepDetails(String prog)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		AssetsDAO as=new AssetsDAO();
		String sql2="select * from assets_register where PROC_MSI_ID='"+prog+"' and status='"+3+"'";
		System.out.println("TrDetails query "+sql2);
		ArrayList ar1=new ArrayList();
		try {
			ar1 = as.select(sql2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("Department Name "+ar1);
		return ar1;
	}
	
	public ArrayList TRDataFromTRtable(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList b3=new ArrayList();
		String sql="select OLD_ASSETS_REG_NO from assets_register where ASSET_REG='"+id+"'";
		System.out.println("select old assets_register no "+sql);
		try {
			b3=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String req_id=b3.get(0).toString().replace("[", "").replace("]", "");
		sql="select REF_NO from assets_register where ASSET_REG='"+req_id+"'";
		System.out.println("Select ref No "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Assets Old register number "+al);
		return al;
	}
	
	public ArrayList TRDataFromTRtableDep(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList b3=new ArrayList();
		String sql="select DEPARTMENT from assets_register where OLD_ASSETS_REG_NO='"+id+"'";
		System.out.println("Department select query "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Assets Department name "+al);
		return al;
	}
	
	public ArrayList ScrapSaleRefNo(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList b3=new ArrayList();
		String sql="select ref_no from assets_register where ASSET_REG='"+id+"'";
		System.out.println("Select ref no "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Assets Old register number "+al);
		return al;
	}
	
	public ArrayList FiveSOwnShName(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		String sql="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+id+"'";
		System.out.println("Facult short name query "+sql);
		try {
			al=ad.select(sql);
			System.out.println("Faculty short name "+al);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return al;
	}
	
	public ArrayList AssetTransferRefAname(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		String sql="select sub_register_no from assets_transfer_ref_tab where req_id='"+id+"'";
		System.out.println("Sub Rejister number "+sql);
		ArrayList a2=new ArrayList();
		try {
			a2=ad.select(sql);
			System.out.println("Sub register number"+a2);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sub_reg=a2.get(0).toString().replace("[", "").replace("]", "");
		sql="select sub_name, ref_no from assets_register where asset_reg='"+sub_reg+"'";
		System.out.println("reference number "+sql);
		try {
			al=ad.select(sql);
			System.out.println("Refrence Number And Name "+al);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return al;
	}
	
	public ArrayList AssetSaleScrapRefAname(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		String sql="select sub_register from assets_sale_scrap_ref_tab where req_id='"+id+"'";
		System.out.println("Sub Rejister number "+sql);
		ArrayList a2=new ArrayList();
		try {
			a2=ad.select(sql);
			System.out.println("Sub register number"+a2);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sub_reg=a2.get(0).toString().replace("[", "").replace("]", "");
		sql="select sub_name, ref_no from assets_register where asset_reg='"+sub_reg+"'";
		System.out.println("reference number "+sql);
		try {
			al=ad.select(sql);
			System.out.println("Refrence Number And Name "+al);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return al;
	}
	
	public ArrayList selectAssetTransfer(int i, String email, String ar3, String msg)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList b3=new ArrayList();
		String bt_id="";
		String sql="";
		switch(i)
		{
		case 1:
			System.out.println("Array List Data Fetch Transfer Data +"+email); 
			String sql1="select batch_mst_id from adm_batch_master where batch_mst_curr='"+1+"'";
			ArrayList ar1=new ArrayList();;
			try {
				ar1 = ad.select(sql1);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			bt_id=ar1.get(0).toString().replace("[", "").replace("]", "");
			System.out.println(bt_id);
			String sql2="select prog_mst_id from director_assign_coordinator where batch_mst_id='"+bt_id+"' and co_type='"+1+"' and co_status='"+1+"' and co_acpt_status='"+2+"'" +
			"and admsn_fac_id='"+email+"'";
			try {
				al=ad.select(sql2);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("department id ="+al);	
			break;
		
		case 2:
			/*String dep_id=ar2.get(0).toString().replace("[", "").replace("]", "");*/
			System.out.println(ar3);
			String str=ar3.replace("[", "").replace("]", "");
			System.out.println("HOD/HOI details id "+email+" department batch_mst_id   Prog_Mst ID"+str);
			sql="select * from assets_transfer where TRANS_PROC_MST_ID_FROM='"+str+"' and STATUS_CUR_HOD='"+0+"'";
			System.out.println("Fetch Assets Transfer "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case 3:
			System.out.println("Assets reg no "+ar3);
			String blnk="";
			sql="select sub_register_no from ASSETS_TRANSFER_REF_TAB where REQ_ID='"+ar3+"'";
			System.out.println("Fetch Assets Transfer "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Found value is "+al);
			break;
			
		case 4:
			System.out.println("Update method");
			//email=status
			//ar3=asset_id
			sql="update assets_transfer set STATUS_CUR_HOD='"+email+"', COMMENT_CUR_HOD='"+msg+"' where REQ_ID='"+ar3+"'";
			System.out.println("Update transfer id "+sql);
			boolean b=ad.insert(sql);
			sql="update ASSETS_TRANSFER_REF_TAB set STATUS_CUR_HOD='"+email+"', COMMENT_CUR_HOD='"+msg+"' where REQ_ID='"+ar3+"'";
			System.out.println("Update transfer id "+sql);
			b=ad.insert(sql);
			sql="select SUB_REGISTER_NO from ASSETS_TRANSFER_REF_TAB where REQ_ID='"+ar3+"'";
			System.out.println("Select query is "+sql);
			try {
				b3 = ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Before Size  "+b3);
			if(email.equals("2"))
			{
				System.out.println("in if Size  "+b3.size());
				for(int m=0;m<b3.size();m++)
				{
					System.out.println("Result in b3 "+b3.get(m));
					ArrayList reg_numb=(ArrayList)b3.get(m);
					System.out.println("REgister ID before "+reg_numb.size()+" VAlue "+reg_numb);
					String reg_id=""+reg_numb.get(0);
					System.out.println("REgister ID "+reg_id);
					sql="update assets_register set status='"+1+"' where asset_reg='"+reg_id+"'";
					System.out.println("update reject status "+sql);
					boolean b2=ad.insert(sql);
					System.out.println("Updated status "+b2);
				}
			}
			String val=String.valueOf(b);
			ArrayList<String> a2=new ArrayList<String>();
			a2.add(val);
			String l[]=val.split(" ");
			System.out.println("Value of bool in arry list "+val+"  "+a2);
			al=a2;
			System.out.println("Added value "+al);
			break;
			
		case 5:
			System.out.println("Assets transfer data");
			String proc_id=ar3.toString().replace("[", "").replace("]", "");
			sql="select * from assets_transfer where STATUS_CUR_HOD='"+1+"' and TRANS_PROC_MST_ID_TO='"+proc_id+"' and STATUS_TRAN_HOD='"+0+"'";
			System.out.println("transfer hod transfer id "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case 6:
			System.out.println("Rejected report");
			ArrayList fin=new ArrayList();
			ArrayList set=new ArrayList();
			ArrayList ar=new ArrayList();
			sql="select * from assets_transfer where created_by='"+email+"' and not status_cur_hod='"+4+"'";
			System.out.println("Status result "+sql );		
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
			System.out.println("Value 1"+al);		
			break;
			
		case 7:
			System.out.println("In case 7");
			sql="select sub_register_no, new_fs_owner, newlocation from assets_transfer_ref_tab where req_id='"+ar3+"'";
			System.out.println("case 7 value is "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case 8:
			break;
			
		case 9:
				// new_id=ar3
			System.out.println("Case 9");
			int n=1;
			sql="select MAIN_CAT, sub_cat, ENTRY_DATE, DESCRIP, BILL_NO, BILL_DATE, DEPARTMENT, QUANTITY, AMOUNT, MAIN_NAME, SUB_NAME from assets_register where asset_reg='"+ar3+"'";
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case 10:
			System.out.println("Case 10");
			//msg = sub_cat
			sql="select max(new_asset_id) from assets_transfer where created_by='"+email+"' and sub_cat='"+msg+"'";
			System.out.println("max found "+sql);
			ArrayList arrb=new ArrayList();
			try {
				arrb = ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String max=arrb.get(0).toString().replace("[", "").replace("]", "");
			System.out.println("max  "+max);
			sql="select * from assets_transfer where created_by='"+email+"' and sub_cat='"+msg+"' and new_asset_id='"+max+"'";
			System.out.println("SQL query  "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case 11:
			System.out.println("Case 11");
			sql="select department, unit, proc_msi_id from assets_register where created_by='"+email+"'";
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("executed value is = "+al);
			break;
			
		case 12:
			System.out.println("Case  f 12");
			//msg=mainCatid
			//ar3=subCatId
			sql="select * from assets_register where main_cat='"+msg+"' and created_by='"+email+"' and status!='"+0+"' and status!='"+3+"' and status!='"+5+"' and status!='"+4+"' and status!='"+7+"' and status!='"+8+"'";
			System.out.println("Query fetched is "+sql );
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("executed value is = "+al);
			break;
			
			
		case 13:
			System.out.println("Case  f 13");
			sql="select * from assets_register where ref_no='"+ar3+"'";
			System.out.println("Query fetched is "+sql );
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("executed value is = "+al);
			break;
			
		case 14:
			System.out.println("Assets reg no "+ar3);
			blnk="";
			sql="select sub_register_no from ASSETS_TRANSFER_REF_TAB where REQ_ID='"+ar3+"'";
			System.out.println("Fetch Assets Transfer "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Found value is "+al);
			break;

		case 15:
			System.out.println("Update method");
			//email=status
			//ar3=asset_id
			sql="update assets_transfer set mt_status='"+email+"', mt_comments='"+msg+"' where REQ_ID='"+ar3+"'";
			System.out.println("Update transfer id "+sql);
			b=ad.insert(sql);
			sql="update ASSETS_TRANSFER_REF_TAB set mt_status='"+email+"', mt_comments='"+msg+"' where REQ_ID='"+ar3+"'";
			System.out.println("Update transfer id "+sql);
			boolean b1=ad.insert(sql);
			val=String.valueOf(b);
			al.add(val);
			System.out.println("Added value "+al);
			break;
		case 16:
			System.out.println("Assets reg no "+ar3);
			blnk="";
			sql="select new_fs_owner from ASSETS_TRANSFER_REF_TAB where sub_register_no='"+ar3+"'";
			System.out.println("Fetch Assets Transfer "+sql);
			ArrayList arr2=new ArrayList();
			try {
				arr2=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String name_id=arr2.get(0).toString().replace("[","").replace("]", "");
			sql="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+name_id+"'";
			System.out.println("Select query "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace(); 
			} catch (CmsNamingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (CmsGeneralException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println("Select query "+al);
			System.out.println("Found value is "+al);
			break;
			
		case 17:
			System.out.println("Assets Data case 17");
			sql="select trans_unit_to, trans_dep_to, trans_proc_mst_id_to from assets_transfer where req_id='"+ar3+"'";
			System.out.println("Assets Data case 17 Qeury "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Case 17 result "+al);
			break;
		default:
			System.out.println("Not valid Option");
			break;
		}
		return al;
	}
	
	
	public ArrayList Asset_Reg_Data_For(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		System.out.println(" 4 not valid");
		String sql = "select * from assets_register where asset_reg='"+id+"'";
		System.out.println("Case 4  query "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Case   query  result "+al);
		return al;
	}
	
	public boolean MT_status_update(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		boolean tf=false;
		System.out.println(" 4 not valid");
		String sql = "update ASSETS_TRANSFER set mt_status='"+0+"' where req_id='"+id+"'";
		System.out.println("Case 4  query "+sql);
		tf=ad.insert(sql);
		System.out.println("Case   query  result "+tf);
		return tf;
	}
	
	
	public ArrayList Asset_MT_Request()
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		System.out.println("MT data");
		String sql = "select * from ASSETS_TRANSFER where status_cur_hod='"+1+"' and status_tran_hod='"+1+"' and mt_status='"+0+"'";
		System.out.println("Result query "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("All value "+al);
		System.out.println("Asset Size "+al.size());
		for(int i=0;i<al.size();i++)
		{
			ArrayList ar=(ArrayList)al.get(i);
			System.out.println("Assets id fetch "+ar.get(13));
		}
		System.out.println("Case   query  result "+al);
		return al;
	}
	
	public ArrayList Asset_trans_hod_appr(String name[], String reg_no[], String email, String ar3, String msg, String location[])
	{
		System.out.println("Update method");
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList b3=new ArrayList();
		boolean b=false;
		boolean b1=false;
		String bt_id="";
		String sql="";
		//email=status
		//ar3=asset_id
		
		sql="update assets_transfer set STATUS_TRAN_HOD='"+email+"', COMMENT_TRAN_HOD='"+msg+"' where REQ_ID='"+ar3+"'";
		System.out.println("Update transfer id "+sql);
		b1=ad.insert(sql);
		System.out.println("true b1 "+b1);
		for(int i=0;i<name.length;i++)
		{
			sql="update ASSETS_TRANSFER_REF_TAB set STATUS_TRAN_HOD='"+email+"', COMMENT_TRAN_HOD='"+msg+"', new_fs_owner='"+name[i]+"', NewLocation='"+location[i]+"' where REQ_ID='"+ar3+"'";
			System.out.println("Update transfer id "+sql);
			b=ad.insert(sql);
			System.out.println("true b "+b);
		}
		if(b==true && b1==true)
		{
			sql="select SUB_REGISTER_NO from ASSETS_TRANSFER_REF_TAB where REQ_ID='"+ar3+"'";
			System.out.println("Select query is "+sql);
			try {
				b3=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Before Size  "+b3);
			if(email.equals("2"))
			{
				System.out.println("in if Size  "+b3.size());
				for(int m=0;m<b3.size();m++)
				{
					System.out.println("Result in b3 "+b3.get(m));
					ArrayList reg_numb=(ArrayList)b3.get(m);
					System.out.println("REgister ID before "+reg_numb.size()+" VAlue "+reg_numb);
					String reg_id=""+reg_numb.get(0);
					System.out.println("REgister ID "+reg_id);
					sql="update assets_register set status='"+1+"' where asset_reg='"+reg_id+"'";
					System.out.println("update reject status "+sql);
					boolean b2=ad.insert(sql);
					System.out.println("Updated status "+b2);
				}
			}
		}
		String val1=String.valueOf(b1);
		ArrayList<String> a3=new ArrayList<String>();
		a3.add(val1);
		String l1[]=val1.split(" ");
		System.out.println("Value of bool in arry list "+val1+"  "+a3);
		al=a3;
		System.out.println("Added value "+al);
		return al;
	}
	
	public boolean AssetRegisterNewAssocAssign(String name[], String reg_no[])
	{
		System.out.println("Update method");
		AssetsDAO ad=new AssetsDAO();
		boolean al=false;
		ArrayList b3=new ArrayList();
		boolean b=false;
		boolean b1=false;
		String bt_id="";
		String sql="";
		//email=status
		//ar3=asset_id
		for(int i=0;i<name.length;i++)
		{
			String upStr="update assets_register set created_by='"+name[i]+"' where asset_reg='"+reg_no[i]+"'";
			System.out.println("String Asset Register Query "+upStr);
			al=ad.insert(upStr);
		}
		return al;
	}
	
	public ArrayList Asset_Tran_fac_info(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList res=new ArrayList();
		System.out.println(" 4 not valid");
		String sql = "select ADMSN_FAC_ID  from admsn_fac_curr_job_info where PROG_MST_ID='"+id+"' and not exists (select * from hr_resignation where admsn_fac_curr_job_info.ADMSN_FAC_ID=hr_resignation.ADM_FAC_ID)";
		System.out.println("Case 4  query "+sql);
		try {
			al=ad.select(sql);
			System.out.println("Case   query  result "+al);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("size "+al.size());
		for(int i=0;i<al.size();i++)
		{
			ArrayList ar=(ArrayList)al.get(i);
			System.out.println("size 2 "+al.size());
			for(int j=0;j<ar.size();j++)
			{
				System.out.println("name "+ar.get(j));
				sql="select ADMSN_FAC_ID, ADMSN_FAC_FNAME, admsn_fac_lname from admsn_faculty_info where ADMSN_FAC_ID='"+ar.get(j)+"'";
				System.out.println("query "+sql);
				try {
					ArrayList data=ad.select(sql);
					System.out.println("Query data "+data);
					System.out.println("true false "+data.isEmpty());
					if(!data.isEmpty())
					{
						for(int k=0;k<data.size();k++)
						{
							ArrayList arr13=(ArrayList)data.get(k);
							System.out.println("in if condition "+arr13);
							System.out.println("id "+arr13.get(0));
							System.out.println("Name "+arr13.get(1));
							res.add(arr13);
						}
					}
					else
					{
						System.out.println("Not Found ");
					}
				} catch (CmsSQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsNamingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsGeneralException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}
		System.out.println("name found "+res);
		return res;
	}
	
	public ArrayList Assets_Sale_scrap_req_id(Dictionary dict)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList a2=new ArrayList();
		DateManager dt=new DateManager();
		String dd=dt.getCurrentDate();
		String tt=dt.getCurrentTime();
		String sql="";
		String blank="";
		String fname="";
		String lname="";
		sql="select admsn_fac_fname, admsn_fac_lname from admsn_faculty_info where admsn_fac_id='"+dict.get("created_by")+"'";
		System.out.println("Query name "+sql);
		ArrayList name=new ArrayList();;
		try {
			name = ad.select(sql);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("faculty name "+name);
		for(int k=0;k<name.size();k++)
		{
			ArrayList ar09=(ArrayList)name.get(k);
			System.out.println("faculty names "+ar09);
			System.out.println("faculty names "+ar09.get(0));
			System.out.println("faculty names "+ar09.get(1));
			fname=ar09.get(0).toString().replace("[", "").replace("]", "");
			lname=ar09.get(1).toString().replace("[", "").replace("]", "");
		}
		String full_name=fname+" "+lname;
		System.out.println("Found first name  "+fname+" Last name "+lname+" full Name "+full_name);
		sql="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+dict.get("created_by")+"'";
		System.out.println("Query name "+sql);
		name=new ArrayList();;
		try {
			name = ad.select(sql);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String sh_name=name.get(0).toString().replace("[", "").replace("]", "").toUpperCase();
		System.out.println("Short name "+sh_name);
		sql="insert into ASSETS_SALE_SCRAP (DEP, UNIT, PROC_MST_ID, HOD_STATUS, MT_STATUS, " +
				"REASON, CREATED_BY_NAME, CREATED_BY_SHNAME, HOD_SH_NAME, CREATED_BY, " +
				"CREATED_ON,CREATED_AT) " +
				"values('"+dict.get("depart")+"','"+dict.get("unit")+"','"+dict.get("prog_mst_id")+"'," +
						"'"+0+"','"+0+"','"+dict.get("reason")+"','"+full_name+"','"+sh_name+"','"+dict.get("hod_sh_name")+"','"+dict.get("created_by")+"'," +
								"'"+dd+"','"+tt+"')";
		System.out.println("SQL = "+sql);
		boolean b=ad.insert(sql);
		if(b==true)
		{
			sql="select max(REQ_ID) from ASSETS_SALE_SCRAP";
			System.out.println("Request id query "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Request id "+al.get(0));
		}
		String result=String.valueOf(b);
		al.add(result);
		System.out.println("Array List "+al);
		return al;
	}
	
	public boolean Assets_Sale_scrap_Data(Dictionary dict, String email)
	{
		System.out.println("Sale scrap form");
		AssetsDAO ad=new AssetsDAO();
		//email=register_id
		String sql="insert into ASSETS_SALE_SCRAP_REF_TAB(REQ_ID, SUB_REGISTER, HOD_STATUS, MT_STATUS) values('"+dict.get("req_id")+"','"+email+"','"+0+"','"+0+"')";
		System.out.println("Insert query "+sql);
		boolean b=ad.insert(sql);
		if(b==true)
		{
			sql="update assets_register set status='"+7+"' where asset_reg='"+email+"'";
			System.out.println("Updated status query "+sql);
			boolean b1=ad.insert(sql);
			System.out.println("Updated assets register "+b1);
		}
		System.out.println("Inserted or no "+b);
		return b;
	}
	
	public ArrayList Asset_transfer(int a,  Dictionary dict, String email, String old_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		ArrayList a2=new ArrayList();
		DateManager dt=new DateManager();
		String dd=dt.getCurrentDate();
		String tt=dt.getCurrentTime();
		String sql="";
		String blank="";
		switch(a)
		{
		case 1:
			//email=prog_mst_id
			sql="select asset_unit_sh, asset_dept_sh from adm_program_master where prog_mst_id='"+email+"'";
			System.out.println("SQL = "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Array List "+al);
			break;
			
		case 2:
			System.out.println("In case 2");
			String fname="";
			String lname="";
			sql="select admsn_fac_fname, admsn_fac_lname from admsn_faculty_info where admsn_fac_id='"+dict.get("created_by")+"'";
			System.out.println("Query name "+sql);
			ArrayList name=new ArrayList();;
			try {
				name = ad.select(sql);
			} catch (CmsSQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (CmsNamingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (CmsGeneralException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println("faculty name "+name);
			for(int k=0;k<name.size();k++)
			{
				ArrayList ar09=(ArrayList)name.get(k);
				System.out.println("faculty names "+ar09);
				System.out.println("faculty names "+ar09.get(0));
				System.out.println("faculty names "+ar09.get(1));
				fname=ar09.get(0).toString().replace("[", "").replace("]", "");
				lname=ar09.get(1).toString().replace("[", "").replace("]", "");
			}
			String full_name=fname+" "+lname;
			System.out.println("Found first name  "+fname+" Last name "+lname+" full Name "+full_name);
			sql="select admsn_fac_sh_name from admsn_faculty_info where admsn_fac_id='"+dict.get("created_by")+"'";
			System.out.println("Query name "+sql);
			name=new ArrayList();;
			try {
				name = ad.select(sql);
			} catch (CmsSQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (CmsNamingException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (CmsGeneralException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String sh_name=name.get(0).toString().replace("[", "").replace("]", "").toUpperCase();
			System.out.println("Short name "+sh_name);
			sql="insert into ASSETS_TRANSFER (TRANS_DEP_FROM, TRANS_UNIT_FROM, TRANS_PROC_MST_ID_FROM, TRANS_DEP_TO, TRANS_UNIT_TO, TRANS_PROC_MST_ID_TO, " +
					"STATUS_CUR_HOD, STATUS_TRAN_HOD, mt_status, CREATED_BY, " +
					"CREATED_ON,CREATED_AT, reason, CREATED_BY_NAME, CREATED_BY_SHNAME, CUR_HOD_SH_NAME, TRANS_HOD_SH_NAME) " +
					"values('"+dict.get("depart")+"','"+dict.get("unit")+"','"+dict.get("prog_mst_id")+"','"+dict.get("tran_dep")+"','"+dict.get("tran_unit")+"'," +
							"'"+dict.get("trans_proc_mst_id")+"','"+0+"','"+0+"','"+0+"','"+dict.get("created_by")+"','"+dd+"','"+tt+"','"+dict.get("reason")+"'," +
									"'"+full_name+"','"+sh_name+"','"+dict.get("cur_hod_sh_name")+"','"+dict.get("trans_hod_sh_name")+"')";
			System.out.println("SQL = "+sql);
			boolean b=ad.insert(sql);
			if(b==true)
			{
				sql="select max(req_id) from ASSETS_TRANSFER";
				System.out.println("Request id query "+sql);
				try {
					al=ad.select(sql);
				} catch (CmsSQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsNamingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (CmsGeneralException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("Request id "+al.get(0));
			}
			String result=String.valueOf(b);
			al.add(result);
			System.out.println("Array List "+al);
			break;
		case 3:
			System.out.println("In case 3");
			//email=register_id
			sql="insert into ASSETS_TRANSFER_REF_TAB(REQ_ID, SUB_REGISTER_NO) values('"+dict.get("req_id")+"','"+email+"')";
			System.out.println("Insert query "+sql);
			b=ad.insert(sql);
			if(b==true)
			{
				sql="update assets_register set status='"+8+"' where asset_reg='"+email+"'";
				System.out.println("Updated status query "+sql);
				b=ad.insert(sql);
				System.out.println("Updated assets register "+b);
			}
			result=String.valueOf(b);
			al.add(result);
			System.out.println("Inserted or no "+al.get(0));
			break;
		case 4:
			/*System.out.println("In case 4 not valid");
			sql = "select * from assets_register where asset_reg='"+email+"'";
			System.out.println("Case 4  query "+sql);
			al=ad.select(sql);*/
			break;
		case 5:
			System.out.println("In case 5");
			//email=request id of assets transfer;
			sql = "select * from ASSETS_TRANSFER where req_id='"+email+"'";
			System.out.println("Case 5  query "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Inserted or no "+al);
			break;
		default:
			System.out.println("Invalid Option");
			break;
		}
		
		
		return al;
		
	}
	
	public ArrayList Asset_data_trans_MT(String req_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		String sql="";
		sql="select * from assets_transfer where req_id='"+req_id+"'";
		System.out.println("Request Mt query "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("result mt "+al);
		return al;
	}
	
	public ArrayList updateAssetsRegister(int a, Dictionary dict, String email, String old_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		DateManager dt=new DateManager();
		String dd=dt.getCurrentDate();
		String tt=dt.getCurrentTime();
		String sql="";
		String blank="";
		switch(a)
		{
		case 1:
			System.out.println("Assets case 1");
			sql="select max(ref_id) from assets_register where sub_cat='"+email+"' and proc_msi_id='"+old_id+"'";
			System.out.println("Asssets max value query "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		case 2:
			System.out.println("Assets case 2");
			sql="select sub_cat_short_name from assets_sub_category where sub_category_id='"+email+"'";
			System.out.println("Asssets cat short "+sql);
			try {
				al=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
		case 3:
			System.out.println("Assets case 3");
			sql="update assets_register set entry_date='"+dd+"', ref_id='"+dict.get("ref_no")+"', ref_no='"+dict.get("new_ref_no")+"', proc_msi_id='"+dict.get("tr_prog_id")+"'," +
					"department='"+dict.get("tr_dep")+"', unit='"+dict.get("tr_unit")+"', created_at='"+tt+"', created_by='"+email+"', created_on='"+dd+"'," +
							"status='"+1+"', comments='"+blank+"', status_on='"+dd+"', status_at='"+tt+"' where asset_reg='"+old_id+"'";
			System.out.println("Asssets cat short "+sql);
			boolean b=ad.insert(sql);
			if(b==true)
			{
				sql="update assets_transfer set trans_hod_appr='"+4+"', cur_hod_appr_status='"+4+"' where new_asset_id='"+dict.get("n_id")+"'";
				System.out.println("Query "+sql);
				boolean b1=ad.insert(sql);
				System.out.println("Boolean value got is "+b1);
			}
			String result=String.valueOf(b);
			
			al.add(result);
			System.out.println("array List "+al);
			break;
		default:
			System.out.println("Invalid Option");
			break;
		}
		
		
		return al;
	}
	
	public boolean UpdateAssetsRegisterTable(int n, String new_ref_no, String proc_id, String dep, String unit, String created_by, String reg_id, String newR_id, Dictionary dict, String tr_hod_sh, String NewLocation)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		DateManager dt=new DateManager();
		String dd=dt.getCurrentDate();
		String tt=dt.getCurrentTime();
		String blank="";
		
		System.out.println("Assets case 3");
		String sql2="insert into assets_register(MAIN_CAT, SUB_CAT, ENTRY_DATE, DESCRIP, BILL_NO, BILL_DATE, SUPPLIER_NAME, QUANTITY, AMOUNT, REF_ID, REF_NO, PROC_MSI_ID, DEPARTMENT, UNIT, CREATED_BY," +
				"CREATED_AT, created_on, status, MAIN_NAME, SUB_NAME, status_by, OLD_ASSETS_REG_NO, TRANSFER_STATUS, NewLocation) values('"+dict.get("main_cat1")+"','"+dict.get("sub_cat")+"','"+dict.get("entry_date")+"'," +
		"'"+dict.get("Descrip")+"','"+dict.get("bill_no")+"','"+dict.get("bill_date")+"','"+dict.get("depart")+"','"+dict.get("quantityt")+"','"+dict.get("amount")+"'," +
		"'"+n+"','"+new_ref_no+"','"+proc_id+"','"+dep+"','"+unit+"','"+created_by+"','"+tt+"','"+dd+"','"+1+"','"+dict.get("main_name")+"','"+dict.get("sub_name")+"','"+tr_hod_sh+"','"+reg_id+"','"+1+"','"+NewLocation+"')";
		boolean tof=ad.insert(sql2);
		System.out.println("Transfer Insert query "+sql2);
		System.out.println("tru false insert result "+tof);
		if(tof==true)
		{
			String sql="update assets_register set status='"+3+"' where asset_reg='"+reg_id+"'";
			System.out.println("Asssets cat short "+sql);
			boolean b=ad.insert(sql);
			System.out.println("update assets register "+b);
			if(b==true)
			{
				sql="update assets_transfer_ref_tab set status_tran_hod='"+4+"', status_cur_hod='"+4+"', mt_status='"+4+"' where req_id='"+newR_id+"'";
				System.out.println("Query "+sql);
				boolean b1=ad.insert(sql);
				System.out.println("Boolean value got is "+b1);
				sql="update assets_transfer set status_tran_hod='"+4+"', status_cur_hod='"+4+"', mt_status='"+4+"' where req_id='"+newR_id+"'";
				System.out.println("Query "+sql);
				boolean b2=ad.insert(sql);
				System.out.println("Boolean value got is "+b2);
			}
		}
		
		System.out.println("array List "+al);
		return tof;
	}
	
	public ArrayList selectAssetsSSData2(String as_reg_id){
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from assets_sale_scrap where assets_num='"+as_reg_id+"'";
		System.out.println("selectAssetsRegisterData2 query ="+sql);
		try {
			rs=ad.select(sql);
			System.out.println("select assets_reg "+rs);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public ArrayList selectAssetsSaleScrapData(String as_reg_id){
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select sub_register from assets_sale_scrap_ref_tab where req_id='"+as_reg_id+"'";
		System.out.println("selectAssetsRegisterData2 query ="+sql);
		try {
			rs=ad.select(sql);
			System.out.println("select assets_reg "+rs);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public ArrayList saleScrapAssetRegisterData(String as_reg_id){
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from assets_register where asset_reg='"+as_reg_id+"'";
		System.out.println("selectAssetsRegisterData2 query ="+sql);
		try {
			rs=ad.select(sql);
			System.out.println("select assets_reg "+rs);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public ArrayList saleScrapTableFetch(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from assets_sale_scrap where req_id='"+id+"'";
		System.out.println("selectAssetsRegisterData2 query ="+sql);
		try {
			rs=ad.select(sql);
			System.out.println("select assets_reg "+rs);
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Fetch "+rs);
		return rs;
	}
	
	public ArrayList selectAssetsRegisterData(String email)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		ArrayList ar1=new ArrayList();
		ArrayList ar2=new ArrayList();		
		String sql1="select batch_mst_id from adm_batch_master where batch_mst_curr='"+1+"'";
		System.out.println("Sql query found is "+sql1);
		try
		{
			ar1=ad.select(sql1);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String id="";
		id=ar1.get(0).toString().replace("[", "").replace("]", ""); //remove the left bracket;
		String sql2="select prog_mst_id from director_assign_coordinator where batch_mst_id='"+id+"' and co_type='"+1+"' and co_status='"+1+"' and co_acpt_status='"+2+"'" +
		"and admsn_fac_id='"+email+"'";
		System.out.println("value got from  director_assign_coordinator table is ="+sql2);
		try {
			ar2=ad.select(sql2);
			System.out.println("executed value is = "+ar2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		ArrayList ar3=new ArrayList();
		
		return ar2;
	}
	
	
	public ArrayList seelctDepartIdName(String email)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		ArrayList ar1=new ArrayList();
		ArrayList ar2=new ArrayList();		
		String sql1="select batch_mst_id from adm_batch_master where batch_mst_curr='"+1+"'";
		System.out.println("Sql query found is "+sql1);
		try
		{
			ar1=ad.select(sql1);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String id="";
		id=ar1.get(0).toString().replace("[", "").replace("]", ""); //remove the left bracket;
		String sql2="select prog_mst_id from director_assign_coordinator where batch_mst_id='"+id+"' and co_type='"+1+"' and co_status='"+1+"' and co_acpt_status='"+2+"'" +
		"and admsn_fac_id='"+email+"'";
		System.out.println("value got from  director_assign_coordinator table is ="+sql2);
		try {
			ar2=ad.select(sql2);
			System.out.println("executed value is = "+ar2);
		} catch (CmsSQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsNamingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (CmsGeneralException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		ArrayList ar3=new ArrayList();
		ArrayList ar5=new ArrayList();
		for(int d=0;d<ar2.size();d++)
		{
			ArrayList depDet=(ArrayList)ar2.get(d);
			System.out.println("Select Prog MST id "+depDet.get(0));
			String str="select prog_mst_id, prog_mst_name from adm_program_master where prog_mst_id='"+depDet.get(0)+"'";
			System.out.println("SQL query "+str);
			try {
				ar3=ad.select(str);
				System.out.println("data result found is "+ar3);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ar5.add(ar3.get(0));
		/*	for(int dep=0;dep<ar3.size();dep++)
			{
				String depDetails=ar3.get(dep).toString().replace("[", "").replace("]", "");
				System.out.println("Departmen data "+depDetails);
				ArrayList data=(ArrayList)ar3.get(dep);
				
			}*/
		}
		System.out.println("Data Of new deparment details "+ar5);
		return ar5;
	}
	
	public ArrayList selectHODHOIDATA(String id)
	{
		/*
		String ms_id[]=new String[ar2.size()];
		ms_id[i]=ar2.get(i).toString().replace("[", "").replace("]", ""); //remove the left bracket;
		System.out.println("aarray"+ms_id[i]+" equals "+ms_id[i].equals(mci_id));*/
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from assets_register where proc_msi_id='"+id+"' and status='"+0+"'";
			System.out.println("selectAssetsRegisterData query ="+sql);
			try
			{
				rs=ad.select(sql);
				System.out.println("select assets_reg "+rs);
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return rs;
	}
	
	public ArrayList selectAssetRegisterData(String id, String created_by)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from assets_register where proc_msi_id='"+id+"' and created_by='"+created_by+"' and status='"+1+"'";
			System.out.println("selectAssetsRegisterData query ="+sql);
			try
			{
				rs=ad.select(sql);
				System.out.println("select assets_reg "+rs);
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return rs;
	}
	
	public ArrayList selectAssetRegisterReferenceNumber(String id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from assets_register where proc_msi_id='"+id+"' and status='"+1+"'";
			System.out.println("selectAssetsRegisterData query ="+sql);
			try
			{
				rs=ad.select(sql);
				System.out.println("select assets_reg "+rs);
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return rs;
	}
	
	public ArrayList selectSaleScrapHODHOIDATA(String id)
	{
		/*
		String ms_id[]=new String[ar2.size()];
		ms_id[i]=ar2.get(i).toString().replace("[", "").replace("]", ""); //remove the left bracket;
		System.out.println("aarray"+ms_id[i]+" equals "+ms_id[i].equals(mci_id));*/
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from ASSETS_SALE_SCRAP where PROC_MST_ID='"+id+"' and HOD_STATUS='"+0+"'";
			System.out.println("selectAssetsRegisterData query ="+sql);
			try
			{
				rs=ad.select(sql);
				System.out.println("select assets_reg "+rs);
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return rs;
	}
	
	public ArrayList AssetsScrapMTDeisp()
	{
		/*
		String ms_id[]=new String[ar2.size()];
		ms_id[i]=ar2.get(i).toString().replace("[", "").replace("]", ""); //remove the left bracket;
		System.out.println("aarray"+ms_id[i]+" equals "+ms_id[i].equals(mci_id));*/
		AssetsDAO ad=new AssetsDAO();
		ArrayList rs=new ArrayList();
		String sql="select * from ASSETS_SALE_SCRAP where HOD_STATUS='"+1+"' and mt_status='"+0+"'";
			System.out.println("selectAssetsRegisterData query ="+sql);
			try
			{
				rs=ad.select(sql);
				System.out.println("select assets_reg "+rs);
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return rs;
	}
	
	public ArrayList selectAssetsStstusData(String as_reg_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		String sql="select created_on, create_by, comments from assets_status where assets_reg_id='"+as_reg_id+"'";
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return al;
	}
	
	public ArrayList selectAssetsSS_StstusData(String as_reg_id)
	{
		AssetsDAO ad=new AssetsDAO();
		ArrayList al=new ArrayList();
		String sql="select created_on, created_by, comments from assets_sale_scrap_status where olg_reg_no='"+as_reg_id+"'";
		System.out.println("Assets sale scrap status query "+sql);
		try {
			al=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return al;
	}
	
	public ArrayList SelectLibraryBookDepartment(String bookId)
	{
		ArrayList ar=new ArrayList();
		AssetsDAO ad=new AssetsDAO();
		String sql="select lib_cat_id from acc_reg where lib_book_id='"+bookId+"'";
		System.out.println("Select deaprtment Query "+sql);
		try {
			ar=ad.select(sql);
		} catch (CmsSQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsNamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CmsGeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Department Name "+ar.isEmpty());
		if(!ar.isEmpty())
		{
			String depId=ar.get(0).toString().replace("[", "").replace("]", "");
			System.out.println("Department ID "+depId);
			sql="select lib_cat_name from Lib_cat_mst where lib_cat_id='"+depId+"'";
			System.out.println("Select deaprtment Name Query "+sql);
			try {
				ar=ad.select(sql);
			} catch (CmsSQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsNamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (CmsGeneralException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ar;
	}
	
}