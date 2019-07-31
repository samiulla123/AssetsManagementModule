/*
 * Created on Oct 6, 2006
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.gen.cms.assets.beans;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;

import com.gen.cms.dbfactory.DBDataSource;
import com.gen.cms.exceptions.CmsGeneralException;
import com.gen.cms.exceptions.CmsNamingException;
import com.gen.cms.exceptions.CmsSQLException;
import com.gen.cms.util.CMSLog;

/**
 * @author Administrator
 * 
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class AssetsDAO {
	private static Connection c = null;

	private Statement s = null;

	private ResultSet r = null;

	private ResultSetMetaData metaData = null;

	CMSLog logs=new CMSLog("AdminDAO",false,true);


	public boolean insert(String sql) {
		try {
			c = DBDataSource.getConnection();
			s = c.createStatement();
			s.executeUpdate(sql);
		} catch (Exception e) {
			logs.err(e,"insert(sql)");
			e.printStackTrace();
			System.out.println("Insert Exception");
			return false;
		} finally {
			try {
				
				DBDataSource.closeConnection(c, s, r);
				System.out.println("Insert method Database Connetion closed");
			} catch (SQLException exSQL) {
				System.out.println("Failed to close insert database connection");
			}
		}
		return true;
	}
	
	

	public ArrayList select(String str) throws CmsSQLException,
			CmsNamingException, CmsGeneralException {
		//System.out.println(str);
		ArrayList arrOuter = new ArrayList();
		ArrayList arrInner = null;
		ArrayList colNames = new ArrayList();
		try {
			c = DBDataSource.getConnection();
			s = c.createStatement();
			r = s.executeQuery(str);
			metaData = r.getMetaData();
			while (r.next()) {
				// System.err.print("\n");
				arrInner = new ArrayList();
				for (int i = 1; i <= metaData.getColumnCount(); i++) {
					String value = r.getString(i);
					arrInner.add(value);
					// System.err.println(metaData.getColumnName(i)+" :"+value);
				}
				arrOuter.add(arrInner);
			}
			return arrOuter;
		} catch (CmsSQLException exSQL) {
			throw new CmsSQLException(exSQL.getMessage());
		} catch (NamingException exNE) {
			throw new CmsNamingException(exNE.getMessage());
		} catch (SQLException exSQL) {
			throw new CmsSQLException(exSQL.getMessage());
		} catch (Exception ex) {
			throw new CmsGeneralException(ex.getMessage());
		} finally {
			try {
				DBDataSource.closeConnection(c, s, r);
			} catch (SQLException exSQL) {
				throw new CmsSQLException(exSQL.getMessage());
				
			}
		}
	}

	public ArrayList selectRoles(String str) throws CmsSQLException,
			CmsNamingException, CmsGeneralException {

		ArrayList arrOuter = new ArrayList();
		ArrayList arrInner = null;
		ArrayList colNames = new ArrayList();
		try {
			c = DBDataSource.getConnection();
			s = c.createStatement();
			r = s.executeQuery(str);
			metaData = r.getMetaData();
			while (r.next()) {
				arrInner = new ArrayList();
				for (int i = 1; i <= metaData.getColumnCount(); i++) {
					String value = r.getString(i);
					arrInner.add(value);
				}
				arrOuter.add(arrInner);
			}
			return arrOuter;
		} catch (CmsSQLException exSQL) {
			throw new CmsSQLException(exSQL.getMessage());
		} catch (NamingException exNE) {
			throw new CmsNamingException(exNE.getMessage());
		} catch (SQLException exSQL) {
			throw new CmsSQLException(exSQL.getMessage());
		} catch (Exception ex) {
			throw new CmsGeneralException(ex.getMessage());
		} finally {
			try {
				DBDataSource.closeConnection(c, s, r);
			} catch (SQLException exSQL) {
				throw new CmsSQLException(exSQL.getMessage());
			}
		}
	}

	public void close() {
		//System.err.println("Closing...");
		try {
			DBDataSource.closeConnection(c, s, r);
			System.out.println("DB close");
		} catch (SQLException exSQL) {
			System.out.println("DB Exception");
		}
	}

	public boolean insert(ArrayList aQueries) throws CmsNamingException,
			CmsSQLException {
		Connection con = null; // Declaring Connection object
		Statement stmt = null; // Declaring Statement object
		// String queryMessage = "Insert Updated Successfully";
		// Message to be displayed.
		// logs.setDebug(false);
		try {
			con = DBDataSource.getConnection(); // Getting database connection
			con.setAutoCommit(false);
			stmt = con.createStatement(); // creating Connection object
			for (int i = 0; i < aQueries.size(); i++) {				
				stmt.execute("" + aQueries.get(i));
			}
			con.commit();
			return true;
		} catch (CmsNamingException cne) {
			logs.err(cne);
			throw new CmsNamingException(cne.getMessage());
		} catch (CmsSQLException cse) {
			logs.err(cse);
			throw new CmsSQLException(cse.getMessage());
		} catch (SQLException sqle) {
			logs.err(sqle);
			throw new CmsSQLException(sqle.getMessage());
		} finally {
			try {
				DBDataSource.closeConnection(con, stmt);				
			} catch (CmsSQLException cse) {
				logs.err(cse);
				throw new CmsSQLException(cse.getMessage());
			}
		}
	}

	public boolean insert(String[] sql) throws CmsSQLException {		
		boolean flag = false;
		int len = 0;
		try {
			c = DBDataSource.getConnection();
			s = c.createStatement();
			for (int i = 0; i < sql.length; i++) {
				len = s.executeUpdate(sql[i]);
			}
			if (len != 0)
				flag = true;
			return flag;
		} catch (SQLException e) {
			logs.err(sql,""+e);			
		} catch (CmsNamingException e) {
			e.printStackTrace();
		} finally {
			try {
				DBDataSource.closeConnection(c, s, r);
			} catch (SQLException exSQL) {
				throw new CmsSQLException(exSQL.getMessage());
			}
		}
		return false;
	}

	public ResultSet getResultSet(String str) throws CmsSQLException,CmsNamingException,CmsGeneralException{
		try {
			c = DBDataSource.getConnection();
			s = c.createStatement();
			r = s.executeQuery(str);
			metaData = r.getMetaData();			
			return r;
		} catch (CmsSQLException exSQL) {
			throw new CmsSQLException(exSQL.getMessage());
		} catch (NamingException exNE) {
			throw new CmsNamingException(exNE.getMessage());
		} catch (SQLException exSQL) {
			throw new CmsSQLException(exSQL.getMessage());
		} catch (Exception ex) {
			throw new CmsGeneralException(ex.getMessage());
		} finally {
			try {
				DBDataSource.closeConnection(c, s, r);
			} catch (SQLException exSQL) {
				throw new CmsSQLException(exSQL.getMessage());
			}
		}		
	}	
	
	public String selectText(String sql) throws CmsNamingException,
			CmsSQLException, CmsGeneralException {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String recordStr = "";
		try {
			con = DBDataSource.getConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql);
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			if (rs.next()) {
				rs.previous();
				while (rs.next()) {				
					recordStr = rs.getString(1);
				}
			}			
			return recordStr;
		} catch (CmsNamingException cne) {
			throw cne;
		} catch (SQLException sqe) {
			logs.err(sql,""+sqe);
			throw new CmsSQLException(sqe.getMessage() + "1");
		} catch (Exception ex) {
			throw new CmsGeneralException(ex.getMessage());
		} finally {
			try {
				DBDataSource.closeConnection(con, stmt, rs);
			} catch (Exception sqe) {
				throw new CmsGeneralException(sqe.toString() + "2");
			}
		}
	}
}

