# Farma News

Microserviço de notícias do projeto farmácia UFJF com core WordPress

## Executar

para inicializar execute

    docker-compose up --build

o microserviço irá inicializar na porta 8000. Ao acessar você deverá realizar uma configuração inicial do site (em breve esta configuração será automática).

Em seguida, acesse http://localhost:8000/wp-admin/options-permalink.php e configure os links permanentes em Nome do post.

o endereço da API fica em http://localhost:8000/wp-json/wp/v2/ . O endereço do painel administrativo fica em http://localhost:8000/wp-admin/ .