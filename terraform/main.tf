resource "docker_image" "todo-image"{

	name = "soma1999/todo_app-node:latest"
	keep_locally=false
}

resource "docker_container" "todo-container"{ 
	image = docker_image.todo-image.name
	name = "todoapp-container"

	ports {
		internal= 8000
		external= 8000
	}

	depends_on = [ 
	docker_image.todo-image
	]
}




















