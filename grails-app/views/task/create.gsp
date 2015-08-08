<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		
		
		<div id="create-task" class="content scaffold-create" role="main">
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${taskInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${taskInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors><br>
			<g:form url="[resource:taskInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<br>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'Salvar Tarefa', default: 'Salvar Tarefa')}" />
					<input type='reset' value='Limpar Tarefa'  class="save" />
				</fieldset>
				
				
			</g:form>
		</div>



	</body>
</html>
