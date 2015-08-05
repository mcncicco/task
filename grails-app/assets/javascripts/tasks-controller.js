tasksController = function() {
    
    function errorLogger(errorCode, errorMessage) {
	    console.log(errorCode +':'+ errorMessage);
    }
    
	var taskPage;
	var initialised = false;   
	
	return {
		init : function(page) {
			if (!initialised) {
			    
				taskPage = page;
				
				$(taskPage).find( '[required="required"]' ).prev('label').append( '<span>*</span>').children( 'span').addClass('required');
				$(taskPage).find('tbody tr:even').addClass( 'even');
				
				$(taskPage).find( '#btnAddTask' ).click( function(evt) {
					evt.preventDefault();
					$(taskPage ).find('#taskCreation' ).removeClass( 'not');
				});
				
						
                $(taskPage).find('#tblTasks tbody').on('click', '.deleteRow', 
                	function(evt) { 					
                		console.log('deletando');
                		storageEngine.delete('task', $(evt.target).data().taskId, 
                			function() {
                				$(evt.target).parents('tr').remove(); 
                			}, errorLogger);
							
							//Ap?s a dele??o da linha, foi necess?rio removel? na "M?o", 
							// pois estava dando conflito com a biblioteca de ordena??o, e essa, foi a solu??o encontrada.
						
							$(evt.target).parent().parent().parent().remove();
							$(evt.target).parent().parent().parent().addClass('not');
							
								
							// Ap?s o evendo ele chama o atualizar, que dentre outras coisa, ordena a tabela, 
							// atualiza o radap? com o n?mero de tarefas, aplica os devidos css, entre outras fun??es
							tasksController.processa();
					}
                );
				
				
				//Atividade 04. 
				// Ap?s o clique no bot?o da tarefa, que se deseja completar, o evento percorre o DOM,
				// at? encontrar a linha, e adiciona o css da tarefa completa, al?m de alterar a linha do Status para sim.
				// A utiliza??o da coluna de status, foi a solu??o utilizada, para definir se uma tarefa estava completa ou n?o, al?m do elemnto css.
				
				$(taskPage).find('#tblTasks tbody').on('click', '.completeRow', 
                	function(evt) { 
					console.log('complementando');
						$(evt.target).parent().parent().parent().addClass('taskCompleted');
						$(evt.target).parent().parent().parent().last().find('td').last().text('Sim');
						
						
						// Ap?s o evendo ele chama o atualizar, que dentre outras coisa, ordena a tabela, 
						// atualiza o radap? com o n?mero de tarefas, aplica os devidos css, entre outras fun??es
						tasksController.processa();
                	}
                );
				
                
                $(taskPage).find('#tblTasks tbody').on('click', '.editRow', 
                	function(evt) { 	

						console.log('editando');	

						//Este if, impede que uma tarefa marcada como finalizada seja editada.
						if (!$(evt.target).parent().parent().parent().hasClass("taskCompleted")) {
							$(taskPage).find('#taskCreation').removeClass('not');
							
							storageEngine.findById('task', $(evt.target).data().taskId, function(task) {
								$(taskPage).find('form').fromObject(task);
							}, errorLogger);
							
							$(evt.target).parent().parent().parent().remove();
							$(evt.target).parent().parent().parent().addClass('not');
							
						}else{
							alert('Tarefa ja foi Finalizada');
						}
						
                	}
                );
				
				//Atividade 02. 
				// Esta funcionalidade, apaga o formul?rio de adi??o e edi??o de um nova tarefa.
				$(taskPage).find('#taskForm').on('click', '#clearTask', 
                	function(evt) { 
						$('#taskForm').each (function(){
							this.reset();
							});
                	}
                );
				
				
				
                $(taskPage).find('#saveTask').click(function(evt) {
                	evt.preventDefault();
						
                	if ($(taskPage).find('form').valid()) {
						console.log('salvando');
                		var task = $(taskPage).find('form').toObject();	
						
						storageEngine.save('task', task, function() {
							// Ap?s a inclus?o da biblioteca de ordenamento, o save, passou a duplicar as linhas da tabela sem motivo aparente.
							// Devido a este fato, foi feito um refatoramento, para garantir que funcionansse corretamente o evento save, com o ordenamento
							
                			$(':input').val('');
							$(taskPage).find('#taskCreation').addClass('not');
                		}, errorLogger);
						
						$('#taskRow').tmpl(task).appendTo( $(taskPage ).find( '#tblTasks tbody'));
					
						// Ap?s o evendo ele chama o atualizar, que dentre outras coisa, ordena a tabela, 
						// atualiza o radap? com o n?mero de tarefas, aplica os devidos css, entre outras fun??es
						
						tasksController.processa();
						
						
                	}
					
                });
                
                storageEngine.init(function() {
					console.log('init');
                		storageEngine.initObjectStore('task', function() {}, 
                		errorLogger) 
                }, errorLogger);
                
				initialised = true;
			}
    	},
    	
		loadTasks : function() {
			console.log('load');
			
		storageEngine.findAll('task', 
			function(tasks) {
				$.each(tasks, function(index, task) {
					$('#taskRow').tmpl(task ).appendTo( $(taskPage ).find( '#tblTasks tbody'));
				});
			}, 
			errorLogger);
			
		},
		
		// Trecho de c?digo adicionada que ? chamado toda vez que a p?gina ? carregada ou algum evento ? acionado, que realiza as atividades solicitadas.
		processa : function() {
			console.log('1 interno');
		

			// Ap?s a execut??o do HTML, ele varre a estrutura da tabela que est? com o status SIM, e atualiza o CSS desta linha
			$('#tblTasks tr').each (function(){
				if ($(this).last().find('td').last().text() == 'Sim') {
					$(this).addClass('taskCompleted');
				}			
			});
			
			
			//Atividade 03. 
			// Ap?s carregamento da p?gina, este trecho do c?digo, atualiza o css das linhas das tarefas, para o css de warning e overdue.
			$('#tblTasks tr').children('td').children('time').each (function(){
		
				var dataTask = new Date($(this).text());
			
			
				if( dataTask < new Date()) {
					$(this).parent().parent().addClass('overdue'); 
				}else if (dataTask - new Date() <= 432000000){
					//Compara??o com milesegundos equivalente a 5 dias.
					$(this).parent().parent().addClass('warning');
				}	
			});
			
			//Atividade 05. Ordena a coluna 2, que ? a das datas da tarefe, por ordem decrescente.
			$('#tblTasks').tablesorter({sortList: [[1,0]]});
			
			//Atividade 01. Atualiza o rodap?, com a quantidade de tarefas existentes que n?o estejam completadas.
			$("#taskCount").html($("#tblTasks tr").not('.taskCompleted').not('.not').length-1); 
	
			
			
			
				
		}
		
	}
}();



