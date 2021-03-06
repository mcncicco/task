<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="/assets/02-tasks.css"  />
  		<!-- asset:stylesheet src="application.css"/ -->
		<!-- asset:javascript src="application.js"/ -->

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		


		
		<g:layoutHead/>
	</head>
	<body>
		<!-- div id="grailsLogo" role="banner"><a href="http://grails.org"><asset:image src="grails_logo.png" alt="Grails"/></a></div -->
		<g:layoutBody/>
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		
<br>
		<ul>

			<li><form action="/task/index">
					 		<input type="submit" value="Tarefas">
							</form></li>

							<li><form action="/categoria/index">
					 		<input type="submit" value="Categorias">
							</form>	</li></ul>
							
						
							
						


	
	</body>
	<script>

$(document).ready(function() {
	
	
	$('#tblTasks tr').each (function(){
				if ($(this).last().find('td').last().text() == 'Sim') {
				
					$(this).addClass('taskCompleted');
				}		else{
				
				}	
			});


			$('#tblTasks tr').children('td').children('time').each (function(){
		
				var dataTask = new Date($(this).text());
			
			
				if( dataTask < new Date()) {
					$(this).parent().parent().addClass('overdue'); 
				}else if (dataTask - new Date() <= 432000000){
					//Compara??o com milesegundos equivalente a 5 dias.
					$(this).parent().parent().addClass('warning');
				}	
			});
	

});


	
</script>
</html>
