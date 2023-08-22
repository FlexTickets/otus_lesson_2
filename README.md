# otus_lesson_2
Lesson 2 - Terraform Practice:
- Create compute instance by Terraform
- Deploy nginx by Ansible playbook

Требования к месту воспроизведения:
- Terraform v. 1.15
- Ansible v. 2.3
Должна быть установлена роль nginxinc.nginx (https://github.com/nginxinc/ansible-role-nginx) и ее зависимости

Для воспроизведения установите переменные окружения для авторизации в YC:
- YC_TOKEN
- YC_CLOUD_ID
- YC_FOLDER_ID
по желанию измените переменные в файле main.auto.tfvars:
- ssh_port - порт, на котором будет поднят sshd
- ssh_user - юзер для логина по ssh
- ssh_public_key_path - путь до файла с публичным ключем ssh
- ssh_private_key_path - путь до файла с секретным ключем ssh

Контент:
- main.auto.tfvars - переопределяемые переменные
- main.tf - terraform манифест создания инстанса и его инициализации, правил фаервола
- outputs.tf - выходные значения с параметрами инстанса
- README.md - файл, который вы читаете
- terraform.tf - конфигурации провайдеров
- variables.tf - переменные
- configs - каталог с конфигами (index.php - PHP приложение, nginx.default.conf - дефолтный конфиг nginx)
- scripts - каталог с конфигами (user-data.yaml - команды, исполняемые в конце cloud-init; wait4finish-cloud-init.sh - скрипт ожидания окончания cloud-init; web.yaml - ansible манифест развертывания nginx и статического PHP приложения)

Команды terraform для воспроизведения:
- terraform init
- terraform apply