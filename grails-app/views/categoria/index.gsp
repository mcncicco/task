
<%@ page import="br.ufpe.cin.Categoria" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'categoria.label', default: 'Categoria')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<header>
			<span>Lista de Categorias</span>
		</header>
		<br>
		
		<div id="list-categoria" class="content scaffold-list" role="main">
			
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<br>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nome" title="${message(code: 'categoria.nome.label', default: 'Nome')}" />
					
						<th></th>
						<th></th>

					</tr>
				</thead>
				<tbody>
				<g:each in="${categoriaInstanceList}" status="i" var="categoriaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: categoriaInstance, field: "nome")}</td>
					

						

						<td>
						    <g:form url="[resource:categoriaInstance, action:'update']" method="PUT">
						        <fieldset class="buttons">
						            <g:actionSubmit class="update" action="edit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
						        </fieldset>
						    </g:form>
						</td>

						<td>
						    <g:form url="[resource:categoriaInstance, action:'delete']" method="DELETE">
						        <fieldset class="buttons">
						            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						        </fieldset>
						    </g:form>
						</td>

					</tr>
				</g:each>
				</tbody>
			</table>
<br>
			<g:form url="[resource:taskInstance, action:'create']">
		        <fieldset class="completeRow">
		            <g:actionSubmit class="completeRow" action="create" value="${message(code: 'Adcionar Tarefa', default: 'Adcionar Categoria')}" />
		        </fieldset>
		    </g:form>
		    <footer>Você tem ${categoriaInstanceCount ?: 0} categorias</footer>
			
			
			
		</div>
	</body>
</html>
