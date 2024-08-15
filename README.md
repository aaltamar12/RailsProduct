# Rails Product API

## Descripción

Este proyecto es una aplicación construida con Ruby on Rails. Este README proporciona instrucciones para configurar, ejecutar y contribuir al proyecto.

## Requisitos

- Ruby 3.x
- Rails 7.x
- PostgreSQL

## Instalación

 **1. Clonar el Repositorio**

```ruby
     git clone https://github.com/aaltamar12/RailsProduct.git
    cd tu_repositorio
```

**2. Instalar las Dependencias**

   Asegúrate de tener Bundler instalado:

```ruby
gem install bundler
```

   Luego instala las gemas necesarias:


```ruby
   bundle install
```

 **3. Configurar la Base de Datos**

Asegúrate de tener un archivo \`config/database.yml\` configurado. Aquí hay un ejemplo de cómo podría verse:

  ```yaml
 default: &default
     adapter: postgresql
     encoding: unicode
     pool: 5
     username: <%= ENV['DB_USERNAME'] %>
     password: <%= ENV['DB_PASSWORD'] %>

   development:
     <<: *default
     database: tu_repositorio_development

   test:
     <<: *default
     database: tu_repositorio_test

   production:
     <<: *default
     database: tu_repositorio_production
     username: <%= ENV['DB_USERNAME'] %>
     password: <%= ENV['DB_PASSWORD'] %>
     host: <%= ENV['DB_HOST'] %>
```

   Luego crea y migra la base de datos:

	rails db:create
	rails db:migrate


**4. Configurar Variables de Entorno**

   Asegúrate de tener el archivo \`config/credentials.yml.enc\` configurado. Si no tienes el \`master.key\`, necesitarás el archivo \`credentials.yml.enc\` para ejecutar la aplicación. Puedes crear un archivo \`credentials.yml.enc\` si no existe, utilizando:

   ```ruby
EDITOR="code --wait" rails credentials:edit
```

   Luego agrega tus credenciales.

5. **Ejecutar el Servidor**

   Inicia el servidor Rails:

   ```ruby
rails s -p 3001
```

   El servidor se ejecutará en \`http://localhost:3001\`.

## Uso

Una vez que el servidor está en funcionamiento, puedes acceder a la aplicación en tu navegador. La aplicación debería estar disponible en \`http://localhost:3001\`.

**Endpoints**
* Product:
	- GET /product/
	- POST /product/
	- GET /product/:id
	- PUT /product/:id
	- DELETE /product/:id

* User:
	- POST /product/
	- POST /product/


## Pruebas

Para ejecutar las pruebas, usa:

```ruby
rails test
```