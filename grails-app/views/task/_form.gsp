<%@ page import="br.ufpe.cin.Task" %>



<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'nome', 'error')} required">
	<label for="nome">
		<g:message code="task.nome.label" default="Nome" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nome" maxlength="45" required="" value="${taskInstance?.nome}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'categoria', 'error')} ">
	<label for="categoria">
		<g:message code="task.categoria.label" default="Categoria" />
		
	</label>
	

	<select id="categoria" name="categoria.id">
	 
	  <g:each in="${br.ufpe.cin.Categoria.list()}" var="taskInstance">
	    
	      <option value="${taskInstance.id}">${taskInstance.nome}</option>
	 
	  </g:each>
	</select>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'completa', 'error')} required">
	<label for="completa">
		<g:message code="task.completa.label" default="Completa" />
		<span class="required-indicator">*</span>
	</label>

	<select id="completa" name="completa">
	<option value="Não">Não</option>

	      <option value="Sim">Sim</option>
	      	 </select>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'deadline', 'error')} required">
	<label for="deadline">
		<g:message code="task.deadline.label" default="Deadline" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="deadline" precision="day"  value="${taskInstance?.deadline}"  />

</div>

