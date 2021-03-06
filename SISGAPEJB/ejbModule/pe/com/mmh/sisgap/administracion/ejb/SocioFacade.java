/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package pe.com.mmh.sisgap.administracion.ejb;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.sql.DataSource;

import pe.com.mmh.sisgap.domain.Socio;

/**
 *
 * @author ANDREA
 */
@Stateless
public class SocioFacade implements SocioFacadeLocal {
	
	//private static final String view_bucar_socio = "select * from view_bucar_socio where tran_razon_social like %s ";
	private static final String view_bucar_socio_nombre = "select * from view_bucar_socio where tran_razon_social like %s ";
	private static final String view_bucar_socio_puesto = "select * from view_bucar_socio where tran_puesto like %s ";
	private static final String view_bucar_socio_dni = "select * from view_bucar_socio where dni like %s ";
	private static final String SP_LST_GENERARNROCOD = "{call PKG_ADMINISTRACION.SP_LST_GENERARNROCOD(?,?)}";
	
	@Resource(name="java:/jdbc/sisgapDS")
	private DataSource dataSource;
	
    @PersistenceContext
    private EntityManager em;

    public void create(Socio socio) {
        em.persist(socio);
    }

    public void edit(Socio socio) {
        em.merge(socio);
    }

    public void remove(Socio socio) {
        em.remove(em.merge(socio));
    }

    public Socio find(Object id) {
        return em.find(Socio.class, id);
    }

    public List<Socio> findAll() {
        return em.createQuery("select object(o) from Socio as o").getResultList();
    }

	@Override
	public List<Socio> buscarxNombre(String nombre) {
		// TODO Auto-generated method stub
		Connection connection = null;
		PreparedStatement pst;
		ResultSet rs;
		List<Socio> lsSocios = null;
		Socio socio = null;
		try {
			connection = getConnection();
			lsSocios = new ArrayList<Socio>();
			pst=connection.prepareStatement(String.format(view_bucar_socio_nombre, "'"+nombre.toUpperCase()+"%'"));
			rs = pst.executeQuery();
			
			while(rs.next()){
				
				socio = new Socio();
				socio.setTranIde(rs.getLong("tran_ide"));
				socio.setTranCodigo(rs.getString("tran_codigo"));
				socio.setTranPuesto(rs.getString("tran_puesto"));
				socio.setTranRazonSocial(rs.getString("tran_razon_social"));
				lsSocios.add(socio);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return lsSocios;
	}
	
	@Override
	public List<Socio> buscarxPuesto(String puesto) {
		// TODO Auto-generated method stub
		Connection connection = null;
		PreparedStatement pst;
		ResultSet rs;
		List<Socio> lsSocios = null;
		Socio socio = null;
		try {
			connection = getConnection();
			lsSocios = new ArrayList<Socio>();
			pst=connection.prepareStatement(String.format(view_bucar_socio_puesto, "'"+puesto.toUpperCase()+"%'"));
			rs = pst.executeQuery();
			
			while(rs.next()){
				
				socio = new Socio();
				socio.setTranIde(rs.getLong("tran_ide"));
				socio.setTranCodigo(rs.getString("tran_codigo"));
				socio.setTranPuesto(rs.getString("tran_puesto"));
				socio.setTranRazonSocial(rs.getString("tran_razon_social"));
				lsSocios.add(socio);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return lsSocios;
	}

	
	@Override
	public List<Socio> buscarxDNI(String dni) {
		// TODO Auto-generated method stub
		Connection connection = null;
		PreparedStatement pst;
		ResultSet rs;
		List<Socio> lsSocios = null;
		Socio socio = null;
		try {
			connection = getConnection();
			lsSocios = new ArrayList<Socio>();
			pst=connection.prepareStatement(String.format(view_bucar_socio_dni, "'"+dni.trim()+"' AND SUBSTR(tran_codigo,1,2) = 'SO'"));
			rs = pst.executeQuery();
			
			while(rs.next()){
				
				socio = new Socio();
				socio.setTranIde(rs.getLong("tran_ide"));
				socio.setTranCodigo(rs.getString("tran_codigo"));
				socio.setTranPuesto(rs.getString("tran_puesto"));
				socio.setTranRazonSocial(rs.getString("tran_razon_social"));
				lsSocios.add(socio);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return lsSocios;
	}

	
	
	@Override
	public String generarNroCodigo(String tipocod) {
    	Connection connection = null;
    	CallableStatement cst = null;
    	String codigo = "";
    	
    	try {
    		connection = getConnection();
			cst = connection.prepareCall(SP_LST_GENERARNROCOD);
			
			cst.setString("P_STR_TIPOCOD", tipocod);
			cst.registerOutParameter("P_COD_CLIENTE", Types.VARCHAR);
			cst.execute();
			
			codigo = cst.getString("P_COD_CLIENTE");
		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally{			
				try {
					if(cst!=null){cst.close();}
					if(connection!=null){connection.close();}					
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return codigo;
	}

	
	public Connection getConnection() throws SQLException{
		return dataSource.getConnection();
	}

}
