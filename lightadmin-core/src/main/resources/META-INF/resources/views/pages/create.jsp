<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="light" uri="http://www.lightadmin.org/tags" %>
<%@ taglib prefix="light-jsp" uri="http://www.lightadmin.org/jsp" %>

<tiles:useAttribute name="domainTypeAdministrationConfiguration"/>

<c:set var="domainTypeName" value="${domainTypeAdministrationConfiguration.domainTypeName}"/>
<c:set var="domainTypeEntityMetadata" value="${domainTypeAdministrationConfiguration.domainTypeEntityMetadata}"/>

<jsp:useBean id="domainTypeEntityMetadata" type="org.lightadmin.core.persistence.metamodel.DomainTypeEntityMetadata"/>

<light:url var="domainBaseUrl" value="${light:domainBaseUrl(domainTypeName)}" scope="page"/>
<light:url var="createObjectUrl" value="${light:domainRestEntityBaseUrl(domainTypeName, '')}" scope="page"/>

<div class="title"><h5>Create <c:out value="${light:capitalize(domainTypeName)}"/></h5></div>

<light-jsp:breadcrumb>
	<light-jsp:breadcrumb-item name="List ${domainTypeName}" link="${domainBaseUrl}"/>
	<light-jsp:breadcrumb-item name="Create ${domainTypeName}"/>
</light-jsp:breadcrumb>

<form id="editForm" onsubmit="return saveDomainObject(this)" class="mainForm">
	<div class="widget">
		<div class="head"><h5 class="iCreate"><c:out value="${light:capitalize(domainTypeName)}"/></h5></div>
		<fieldset>
			<c:forEach var="fieldEntry" items="${domainTypeAdministrationConfiguration.formViewFragment.fields}"
					varStatus="status">
				<c:if test="${!fieldEntry.primaryKey}">
					<div id="${fieldEntry.uuid}-control-group" class="rowElem ${status.first ? 'noborder' : ''}">
						<label><c:out value="${light:capitalize(fieldEntry.name)}"/>:</label>

						<div class="formRight">
							<light-jsp:edit-control attributeMetadata="${fieldEntry.attributeMetadata}"
													cssClass="input-xlarge" errorCssClass="error"/>
						</div>
						<div class="fix"></div>
					</div>
				</c:if>
			</c:forEach>
		</fieldset>
		<div class="wizNav">
			<input id="cancel-changes" class="basicBtn" value="Cancel" type="button" onclick="history.back();">
			<input id="save-changes" class="blueBtn" value="Save" type="submit">
		</div>
	</div>
</form>

<script type="text/javascript">
	$( function () {
		$( ".chzn-select" ).chosen();

		$( "select, input:checkbox, input:radio, input:file" ).uniform();

		$( ".input-date" ).datepicker( {
										autoSize: true,
										appendText: '(YYYY-MM-DD)',
										dateFormat: 'yy-mm-dd'
									} );
		$( ".input-date" ).mask( "9999-99-99" );

		DOMAIN_TYPE_METADATA = <light:domain-type-metadata-json domainTypeMetadata="${domainTypeEntityMetadata}"/>;
		REST_REPO_URL = "${createObjectUrl}";
	} );
</script>
