package br.ufpe.cin



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TaskController {

    static allowedMethods = [
        save: "POST", update: "PUT", delete: "DELETE"
        index: 'GET', show: 'GET', create: 'GET', edit: 'GET', 
    ]



     def index(Integer max) {
        System.out.println("Indexxxxxxx")
        System.out.println("Index3")
        Integer count = Task.count()
        System.out.println("Index2")
        System.out.println(count);
        for(Task t : Task.list(params)){
            if(t.completa.equals("Sim")){
                count = count -1
            }
        }
        System.out.println(count);

     
    
        respond Task.list(sort: "deadline"), model:[taskInstanceCount: count]
    }



    def show(Task taskInstance) {
        log.info "Show"
        respond taskInstance
    }

    def create() {
        System.out.println("Create");
        respond new Task(params)
    }

    @Transactional
    def save(Task taskInstance) {
        System.out.println("Save");
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view:'create'
            return
        }

        taskInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
                 redirect(controller: "task", action: "index")
            }
            '*' { respond taskInstance, [status: CREATED] }
        }
    }

    def edit(Task taskInstance) {
        System.out.println("Edit");
        if(taskInstance.completa.equals("Sim")){
            flash.message = message(code: 'Esta Tarefa já foi completada! Não pode ser editada!', args: [message(code: 'bbb', default: 'cccc'), taskInstance.id])
            redirect(controller: "task", action: "index")
            
        }else{
            respond taskInstance    
        }
        
    }
    def complete(Task taskInstance) {
        System.out.println("Complete");
        taskInstance.completa = "Sim"
        taskInstance.save flush:true
        redirect(controller: "task", action: "index")
    }

    @Transactional
    def update(Task taskInstance) {
        System.out.println("Update");
        if (taskInstance == null) {
            notFound()
            return
        }

        if (taskInstance.hasErrors()) {
            respond taskInstance.errors, view:'edit'
            return
        }

        taskInstance.save flush:true

        request.withFormat {
            form multipartForm {
               // flash.message = message(code: 'default.updated.message', args: [message(code: 'Task.label', default: 'Task'), taskInstance.id])
               redirect(controller: "task", action: "index")
            }
            '*'{ respond taskInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Task taskInstance) {
        System.out.println("Delete");

        if (taskInstance == null) {
            notFound()
            return
        }

        taskInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Task.label', default: 'Task'), taskInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
