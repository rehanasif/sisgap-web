package pe.com.mmh.sisgap.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * SisgapServicioitem generated by hbm2java
 */
@Entity
@Table(name="SISGAP_SERVICIOITEM", catalog = "", schema="SISGAP")
@NamedQueries({
	@NamedQuery(name = "ServicioItem.findAll", query = "SELECT i FROM ServicioItem i") })

public class ServicioItem  implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
    @Column(name="COD_SERVICIOITEM", unique=true, nullable=false, precision=22, scale=0)
     private BigDecimal codServicioitem;
     @Column(name="STR_DESCRIPCION", length=200)
     private String strDescripcion;
    @Column(name="NUM_COSTO", precision=8)
     private BigDecimal numCosto;
    @Column(name="NUM_ESTADO", precision=1, scale=0)
     private Boolean numEstado;
    @Column(name="DAT_FECHACREA")
     private Date datFechacrea;
    
    public ServicioItem() {
    }
	
    public ServicioItem(BigDecimal codServicioitem) {
        this.codServicioitem = codServicioitem;
    }
    
    public ServicioItem(BigDecimal codServicioitem, String strDescripcion, BigDecimal numCosto, Boolean numEstado, Date datFechacrea) {
       this.codServicioitem = codServicioitem;
       this.strDescripcion = strDescripcion;
       this.numCosto = numCosto;
       this.numEstado = numEstado;
       this.datFechacrea = datFechacrea;
    }
   
    public BigDecimal getCodServicioitem() {
        return this.codServicioitem;
    }
    
    public void setCodServicioitem(BigDecimal codServicioitem) {
        this.codServicioitem = codServicioitem;
    }
    
    
    public String getStrDescripcion() {
        return this.strDescripcion;
    }
    
    public void setStrDescripcion(String strDescripcion) {
        this.strDescripcion = strDescripcion;
    }
    
        public BigDecimal getNumCosto() {
        return this.numCosto;
    }
    
    public void setNumCosto(BigDecimal numCosto) {
        this.numCosto = numCosto;
    }
    
        public Boolean getNumEstado() {
        return this.numEstado;
    }
    
    public void setNumEstado(Boolean numEstado) {
        this.numEstado = numEstado;
    }
    
        public Date getDatFechacrea() {
        return this.datFechacrea;
    }
    
    public void setDatFechacrea(Date datFechacrea) {
        this.datFechacrea = datFechacrea;
    }

	@Override
    public int hashCode() {
        int hash = 0;
        hash += (codServicioitem != null ? codServicioitem.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ServicioItem)) {
            return false;
        }
        ServicioItem other = (ServicioItem) object;
        if ((this.codServicioitem == null && other.codServicioitem != null) || (this.codServicioitem != null && !this.codServicioitem.equals(other.codServicioitem))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "pe.com.mmh.sisgap.domain.ServicioItem[codServicioitem=" + codServicioitem + "]";
    }


}