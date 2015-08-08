<%@ page import="br.ufpe.cin.Task" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		

	</head>
	<body>
		<header>
			<span>Lista de Tarefas</span>
		</header>
		
		
		<div id="list-task" class="content scaffold-list" role="main">
			<br>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="tblTasks">
			<br>
			<thead>
					<tr>
					
						<th><g:message code="task.nome.label" default="Nome" /></th>

						<th><g:message code="task.deadline.label" default="Deadline" /></th>
					<th><g:message code="task.categoria.label" default="Categoria" /></th>
					
						
						<th colspan="3">Ação</th>

						<th><g:message code="task.completa.label" default="Completa" /></th>
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${taskInstanceList}" status="i" var="taskInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: taskInstance, field: "nome")}</td>

						<td>

<time datetime="${taskInstance.deadline}">${taskInstance.deadline} </time>

						
					
						<td>${fieldValue(bean: taskInstance, field: "categoria.nome")}</td>
					
						
						
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

			
<br>
			<g:form url="[resource:taskInstance, action:'create']">
		        <fieldset class="completeRow">
		            <g:actionSubmit class="completeRow" action="create" value="${message(code: 'Adcionar Tarefa', default: 'Adcionar Tarefa')}" />
		        </fieldset>
		    </g:form>
			<footer>Você tem ${taskInstanceCount ?: 0} tarefas</footer>

			
			
		</div>
	</body>



</html>


