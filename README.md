# rep-demo

При создании БД через rake db:setup, дает ошибку при выполнении миграций.

Для создания в бд нужных расширений пользователю нужно дать права создания расширений, или создать их в бд предварительно, тогда в миграции не будет ошибок.

`sudo su postgres`
`createuser -l -P rep-demo` # пароль rep-demo
`createdb -O rep-demo rep-demo`
`exit`
`rake db:migrate`
`rake db:seed`
`rails s`

Для postgres необходимо установить postgis

Без тестов.