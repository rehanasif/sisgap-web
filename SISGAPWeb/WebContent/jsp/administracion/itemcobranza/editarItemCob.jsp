<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="pe.com.mmh.sisgap.system.propiedades.PropiedadesSistema"%>
<%@include file="../../../taglibs.jsp"%>
<%@page import="pe.com.mmh.sisgap.comun.constantes.Constantes"%>
<%@page import="pe.com.mmh.sisgap.system.domain.Parametro"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">
$(function() {

	$("#btn-Grabar").button();
	$("#btn-Cancelar").button();
	
});

function grabar() {
	var concepto = $('[name=txtconcepto]').val().trim();
	var txtcosto = $('[name=txtcosto]').val().trim();
	var txtmoned = $('[name=cbmoneda]').val();
	var txtmedid = $('[name=cbmedida]').val();
	var txtcobra = $('[name=cbtipocobranza').val();
	var txtvaria = $('[name=cbcostovariable').val();
	var txtsocio = $('[name=cbcobrosocio').val();
	var txtestad = $('[name=cbestado').val();

	if(concepto==""){
		alert("Debe ingresar el Concepto");
		$('[name=txtconcepto]').focus();
		return false;
	}
	if(txtcosto==""){
		alert("Debe ingresar el Costo");
		$('[name=txtcosto]').focus();
		return false;
	}
	if(txtmoned=="") {
		alert("Debe seleccionar el Tipo de Moneda");
		$('[name=cbmoneda]').focus();
		return false;
	}
	if(txtmedid=="") {
		alert("Debe seleccionar la Unidad de Medida");
		$('[name=cbmedida]').focus();
		return false;
	}
	if(txtcobra=="") {
		alert("Debe seleccionar el Tipo de Cobranza");
		$('[name=cbtipocobranza]').focus();
		return false;
	}
	if(txtvaria=="") {
		alert("Debe seleccionar el Tipo de Costo");
		$('[name=cbcostovariable]').focus();
		return false;
	}
	if(txtsocio=="") {
		alert("Debe seleccionar si el item es afecto a todos los socios [s/n]");
		$('[name=cbcobrosocio]').focus();
		return false;
	}
	if(txtestad=="") {
		alert("Debe seleccionar el Estado del Item");
		$('[name=cbestado]').focus();
		return false;
	}


	var frm = document.agregarItem;
	frm.metodo.value = 'actualizar';
	frm.submit();

}
function lstCancelar() {
	var frm = document.agregarItem;
	frm.metodo.value = 'cargarAction';
	frm.submit();

}

function isNumber(obj){
	var s=obj.value;
	flag=true;
	if(isEmpty(s))
		if(isNumber.arguments.length==1)
			return defaultEmptyOK;
		else
			return (isNumber.arguments[1]==true);

	for(var i=0;i<s.length;i++){
		var c=s.charAt(i);
		if(!isDigit(c)){
			if(c!="."){
				alert("Sólo se admiten dígitos");
				obj.value="";
				obj.focus();
				flag=false;
				return false;			
			}
			return false;
		}
	}
	if(flag){
		if(obj.value<1){
			alert("Se debe ingresar un monto mayor a cero");
			obj.value="";
			return false;
		}
	}

	return true;
}

</script>
</head>
<body>

	<html:form action="/gestionarItemCobranza.do" method="post" styleId="agregarItem">
		<input type="hidden" name="metodo" value="grabar"/>

		<table border="0" width="885" class="tahoma11" cellpadding="3"
			cellspacing="1">
			<tr bgcolor="#EFF3F9">
				<td width=885 align="left" class="titulo">Administración /
					Item de Cobranza</td>
			</tr>
		</table>
		<table align="center">
			<tr>
				<td id="mensaje" align="center" valign="middle"
					style="display: none"></td>

				<td id="error" align="center" valign="middle" class="mensajeError"
					style="display: none"></td>

			</tr>
		</table>
		<logic:notEmpty name="error">
			<table align="center">
				<tr>

					<td id="error" align="center" valign="middle" class="mensajeError">
						${error}</td>
				</tr>
			</table>
		</logic:notEmpty>

		<logic:notEmpty name="mensaje">
			<table align="center" id="tabalMensaje">
				<tr>
					<td id="mensaje" align="center" valign="middle"
						class="mensajeExito">${mensaje}</td>
				</tr>
			</table>
		</logic:notEmpty>

		<fieldset>
			<legend>
				<span class="titulo">Nuevo Registro
				<table border="0" cellpadding="2" cellspacing="2" width="350px">
					<tr>
						<td width="200" align="right">Concepto</td>
						<td><input type="text"  size="50" name="txtconcepto" value="${objItem.strDescripcion}"/></td>
					</tr>
					<tr>
						<td align="right">Concepto Padre</td>
						<td>
							<select id="cbConceptPadre" name="cbConceptPadre" style="width: 300px">
								<option value="0" selected>Seleccione</option>
								<c:forEach items="${lstCob}" var="row">
									<c:choose>
										<c:when test="${objItem.numCodItemPadre == row.codItemcobranza }">
											<option value="${row.codItemcobranza}" selected="selected">${row.strDescripcion}</option>
										</c:when>
										<c:otherwise>
											<option value="${row.codItemcobranza}">${row.strDescripcion}</option>
										</c:otherwise>
									</c:choose>
																			
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">Recibo de Luz</td>
						<td>
							<select id="cbReciboLuz" name="cbReciboLuz" style="width: 150px">
								<option value="0" selected="selected">Seleccione</option>
								<c:forEach items="${lstOrg}" var="row">
									<c:choose>
										<c:when test="${objItem.codReciboLuz == row.codOrgreciboLuz }">
											<option value="${row.codOrgreciboLuz}" selected="selected">${row.fecPeriodo}</option>
										</c:when>
										<c:otherwise>
											<option value="${row.codOrgreciboLuz}">${row.fecPeriodo}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</td>
					</tr>	
					<tr>
						<td align="right">Costo</td>
						<td><input type="text" size="10" name="txtcosto" onchange="isNumber(this)" value="${objItem.numCosto}"/></td>
					</tr>
					<tr>
						<td align="right">Moneda</td>
						<td>
							<select id="cbmoneda" name="cbmoneda" style="width: 100px">
								<option value="" selected>Seleccione</option>
								<c:choose>
									<c:when test="${objItem.strMoneda =='S' }">
										<option value="S" selected>Soles</option>
										<option value="D">Dolares</option>
									</c:when>
									<c:when test="${objItem.strMoneda =='D' }">
										<option value="S">Soles</option>
										<option value="D" selected >Dolares</option>
									</c:when>																
								</c:choose>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">U/M</td>
						<td>
							<select id="cbmedida" name="cbmedida" style="width: 100px">
								<option value="">Seleccione</option>
								<c:forEach items="${lstMedidas}" var="row">
									<c:choose>
									<c:when test="${row.codUnimedida == objItem.unidadmedida.codUnimedida}">
										<option value="${row.codUnimedida}" selected>${row.strNombre}</option>
									</c:when>
									<c:otherwise>
										<option value="${row.codUnimedida}">${row.strNombre}</option>										
									</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">Tipo de Cobranza</td>
						<td>
							<select id="cbtipocobranza" name="cbtipocobranza" style="width: 100px">
								<option value="" selected>Seleccione</option>
								<c:choose>
									<c:when test="${objItem.strTipocobranza =='C' }">
										<option value="C" selected>Contable</option>
										<option value="N">No Contable</option>
									</c:when>
									<c:when test="${objItem.strTipocobranza =='N' }">
										<option value="C">Contable</option>
										<option value="N" selected>No Contable</option>
									</c:when>																
								</c:choose>								
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">Fecha Caducidad</td>
						<td><input type="text" size="50" name="fechacaducidad" style="width: 70px;" value="${objItem.datFechaFin }"/></td>
					</tr>
					<tr>
						<td align="right">Cobro Adicional</td>
						<td><input type="text"  size="50" name="txtcobroadicional" onchange="isNumber(this)" style="width: 50px;" value="${objItem.numCobroAdicional }"/></td>
					</tr>
					<tr>
						<td align="right">Costo Variable</td>
						<td>
							<select id="cbcostovariable" name="cbcostovariable" style="width: 100px">
								<option value="" selected>Seleccione</option>
								<c:choose>
									<c:when test="${objItem.strFlgVariable == 'S' }">
										<option value="S" selected>Si</option>
										<option value="N">No</option>									
									</c:when>
									<c:when test="${objItem.strFlgVariable == 'N' }">
										<option value="S">Si</option>
										<option value="N" selected>No</option>									
									</c:when>
									<c:when test="${objItem.strFlgVariable == null }">
										<option value="S">Si</option>
										<option value="N">No</option>
									</c:when>
								</c:choose>
							</select><font color="red"> * </font>
						</td>
					</tr>
					<tr>
						<td align="right">Cobro Socio</td>
						<td>
							<select id="cbcobrosocio" name="cbcobrosocio" style="width: 100px" tabindex="12">
								<option value="" selected>Seleccione</option>
								<c:choose>
									<c:when test="${objItem.strFlgCobroSocio == 'G' }">
										<option value="G" selected>General</option>
										<option value="I">Individual</option>
									</c:when>
									<c:when test="${objItem.strFlgCobroSocio == 'I' }">
										<option value="G">General</option>
										<option value="I" selected>Individual</option>
									</c:when>
									<c:when test="${objItem.strFlgCobroSocio == null }">
										<option value="G">General</option>
										<option value="I">Individual</option>
									</c:when>
								</c:choose>
							</select><font color="red"> * </font>
						</td>
					</tr>
					<tr>
						<td align="right">Estado</td>
						<td>
							<select id="cbestado" name="cbestado" style="width: 100px">
								<option value="" selected>Seleccione</option>
								<c:choose>
									<c:when test="${objItem.numEstado == 1 }">
										<option value="1" selected>Activo</option>
										<option value="0">Inactivo</option>
									</c:when>
									<c:when test="${objItem.numEstado == 0 }">
										<option value="1">Activo</option>
										<option value="0" selected>Inactivo</option>
									</c:when>																
								</c:choose>									
							</select>
						</td>
					</tr>
					<tr>
						<td align="center"><input type="button"	id="btn-Grabar" value="Grabar" onclick="grabar()" /></td>
						<td align="center"><input type="button"	id="btn-Cancelar" value="Cancelar" onclick="lstCancelar()" /></td>
					</tr>
				</table>
				</span>
			</legend>
		</fieldset>        

	<div style="display: none;">
		<div id="inline1" style="width:600px;height:300px;overflow:auto;">
			Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam quis mi eu elit tempor facilisis id et neque. Nulla sit amet sem sapien. Vestibulum imperdiet porta ante ac ornare. Nulla et lorem eu nibh adipiscing ultricies nec at lacus. Cras laoreet ultricies sem, at blandit mi eleifend aliquam. Nunc enim ipsum, vehicula non pretium varius, cursus ac tortor. Vivamus fringilla congue laoreet. Quisque ultrices sodales orci, quis rhoncus justo auctor in. Phasellus dui eros, bibendum eu feugiat ornare, faucibus eu mi. Nunc aliquet tempus sem, id aliquam diam varius ac. Maecenas nisl nunc, molestie vitae eleifend vel, iaculis sed magna. Aenean tempus lacus vitae orci posuere porttitor eget non felis. Donec lectus elit, aliquam nec eleifend sit amet, vestibulum sed nunc.
		</div>
	</div>

	</html:form>

</body>
</html:html>