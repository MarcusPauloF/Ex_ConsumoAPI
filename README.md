# consumo_servico_avancado

Este código é uma aplicação Flutter que faz requisições HTTP (GET, POST, PUT, PATCH, DELETE) a um servidor remoto usando a biblioteca http. A classe Home é uma tela que apresenta botões para fazer essas requisições. A classe _HomeState contém os métodos que realizam as requisições HTTP, usando o objeto http para enviar as requisições. Os dados retornados são decodificados de JSON para um objeto Dart e exibidos na tela em uma lista. Além disso, o resultado das requisições é exibido no console, incluindo o código de status e o corpo da resposta.

# O que usei nele ?

👉Consumo de serviços HTTP usando a biblioteca http.<br>
 
👉Parsing de JSON com json.decode() e json.encode() para enviar ou receber dados no formato JSON.<br>

👉Utilização de Future para fazer requisições assíncronas.<br>

👉Utilização de FutureBuilder para atualizar a interface de usuário baseada em dados assíncronos.<br>

👉CRUD (Create, Read, Update e Delete) com requisições HTTP (POST, GET, PUT e DELETE).<br>
