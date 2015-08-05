<%@ page import="br.ufpe.cin.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<link rel="stylesheet" href="/task/assets/02-tasks.css"  />

	</head>
	<body>
		<header>
			<span>Lista de Tarefas</span>
		</header>
		<a href="#list-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-task" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="tblTasks">
			<thead>
					<tr>
					
						<th><g:message code="task.nome.label" default="Nome" /></th>

						<th><g:message code="task.categoria.label" default="Categoria" /></th>
					
						<th><g:message code="task.deadline.label" default="Deadline" /></th>
					
						<th colspan="3">Ação</th>

						<th><g:message code="task.completa.label" default="Completa" /></th>
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${taskInstanceList}" status="i" var="taskInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${taskInstance.id}">${fieldValue(bean: taskInstance, field: "nome")}</g:link></td>
					
						<td>${fieldValue(bean: taskInstance, field: "categoria.nome")}</td>
					
						<td><g:formatDate date="${taskInstance.deadline}" /></td>
						
						<td>
						    <g:form url="[resource:taskInstance, action:'update']" method="PUT">
						        <fieldset class="editRow">
						            <g:actionSubmit class="editRow" action="edit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
						        </fieldset>

						    </g:form>


						</td>

						<td>
						    <g:form url="[resource:taskInstance, action:'delete']" method="DELETE">
						        <fieldset class="deleteRow">
						            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						        </fieldset>
						    </g:form>
						</td>
						<td>
						    <g:form url="[resource:taskInstance, action:'complete']">
						        <fieldset class="completeRow">
						            <g:actionSubmit class="complete" action="complete" value="${message(code: 'default.button.complete.label', default: 'Complete')}" />
						        </fieldset>
						    </g:form>
						</td>

						<td>${fieldValue(bean: taskInstance, field: "completa")}</td>
					
						
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${taskInstanceCount ?: 0}" />
			</div>
		</div>
	</body>



</html>


