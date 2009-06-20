Instalação do ambiente
======================

No Windows XP
-------------

- Instalação do Ruby (Final release - 1.8.6.26)
  - download do windows installer em http://rubyonrails.org/download
  - instalação do executável (eu geralmente instalo no c:/ ruby, seguindo todas as recomendações do instalador)
- Instalação do Rails
  - abrir prompt e digitar o comando "gem istall rails". Se houver um proxy, deve ser configurada a variável de ambiente HTTP_PROXY; caso contrário, a instalação não será bem sucedida. Exemplo de configuração: "HTTP_PROXY=http://myproxy.com.br:5678"
  - a instalação do Rails é sempre lenta no Windows, podendo não ser possível de forma alguma em máquinas que não possuam no mínimo 500Mb de RAM
  - ao ser perguntado pela confirmação de instalação de dependencias, responda Y a todas, ou seja, instale todas as dependências
- Instalação do banco de dados Mysql
  - efetuar download no site do MySql (dev.mysql.com). A última ul de onde baixei foi http://dev.mysql.com/get/Downloads/MySQL-5.1/mysql-essential-5.1.34-win32.msi/from/pick#mirrors
  - instalar o mysql, preferencialmente versão completa. Não esqueça de marcar a opção "Configure MysqlServer now" 
  - continuar no wizard de configuração, selecionando "Detailed Configuration", logo a seguir "Server Machine","Multifunctional Database". Geralmente, eu sigo a recomendação do wizard em relação ao path de instalação
  - na tela de número de configuração de conexão, eu utilio "Online Transactin Processing (OLTP)". Escolha a opção que melhor se adapta ao perfil de utlzação do banco em sua instituição
  - na tela de opções de rede, mantenha as configurações recomendadadas;
  - na tela de configuração de caracteres, selecione a opção "Best Suppport for Multilingualism"
  - instale como serviço, se desejar. É mais fácil de manter o serviço sempre "up"
  - na tela das configurações de segurança, digite uma nova senha para o usuário root, por questões de segurança. O usuário padrão (default) será "root". habilite o check box "Enable root access from remote machine"
  - execute. Caso apareça alguma mensagem de erro, feche as janelas, execute o instalador novamente, selecionado a opção "Repair". Verifique se o serviço está rodando (services.msc no prompt)

Instalação da Aplicação
=======================

A aplicação pode ser obtida de pelo menos duas formas: via git clone (se você não conhece git, é hora de conhecer) ou por download do Github, aqui mesmo onde você está. Uma vez em sua máquina, é necessário configurar o acesso ao banco de dados. Vários bancos podem ser utilizados, entre eles MySQl, PostgreSQL, Sql Server e DB2. 

- Instalação de adapter e configuração da aplicação
  - na aplicação, renomeie o arquivo config/database_mysql.yml para config/database.yml e altere username, password e host, conforme necessário. Não esqueça que é necessário instalar o adapter correto de seu banco. No caso do MySQl, abra novamente o prompt e digite o comando "gem install mysql". Selecione a opção adequada; no meu caso, 1 (mysql 2.7.3 (mswin32). Se você obtiver a mensagem "Successfully installed mysql-xxx, a instalação foi bem sucedida; outras eventuais mensagens de erro podem ser ignoradas
  - é necessário, ainda, disponibilizar a dll do MySQL para que o ruby a conheça. Efetue download da dll em http://www.marciaalmeida.blog.br/wp-content/uploads/2009/05/libmysql.dll. Copie para "<unidade>:\<local de instalação do ruby>\bin"

- Criação da base de dados
  - no diretório da aplicação (exemplo d:/ouvidoria), abra o prompt e execute o comando rake db:init. Serão criadas as estruturas de banco de dados necessárias para funcionamento da versão 0.5.1. Será também criado um usuário padrão para utilização do sistema (usuário: admin, senha: ouvidoria). O sistema solicitará a digitação do e-mail do administrador do sistema, esteja atento. Se tudo der certo, será exibida mensagem final "Setup concluido com sucesso"

- Disponibilização da aplicação via web - é necessário instalar um servidor próprio para disponibilização de sistemas rails. Em windows, eu utilizo Mongrel. Há diversas maneiras de configurar, inclusive utilizando Apache. Colocarei aqui a forma mais simples
  - digite no prompt o comando "gem install mongrel"
  - digite no prompt o comando "gem install mongrel_service"
  - eu costumo instalar as aplicações como serviços do windows. Para tanto, digite o seguinte comando no prompt "mongrel_rails service::install -N ouvidoria -c <unidade>://<local da aplicacao> -e production -p 4000". o parâmetro -N é o nome do serviço que será instalado, -c é o caminho para a aplicação, -e é o ambiente, que pode ser de produção ou desenvolvimento, e -p é a porta em que o serviço irá executar
  - após instalada a aplicação como serviço, e com o serviço rodando, basta acessar a partir de qualquer navegador através da url http://<nome da maquina ou ip>:<numero da porta>/demandas.

Após todos esses passos, testar a aplicação cadastrando novos usuários.

Era isso, por enquanto.

Marcia Almeida

marcia.almeida@camarapoa.rs.gov.br
chuvi.chuvi@gmail.com

marciaalmeida.blog.br
 


