# cuckoo

Сервис для отправки оригинальных текстов в [Яндекс.Вебмастер](http://webmasters.yandex.ru/) через [Yandex API](http://api.yandex.ru/webmaster/).

> Если вы публикуете на своем сайте оригинальные тексты, а их перепечатывают другие интернет-ресурсы, предупредите Яндекс о скором выходе текста. Мы будем знать, что оригинальный текст впервые появился именно на вашем сайте, и попробуем использовать это в настройке поисковых алгоритмов.

> Пожалуйста, загружайте только оригинальные тексты, которые до сих пор не были опубликованы в интернете. Рекомендуемый минимальный объем – 500 знаков, максимальный — 32000 знаков. Вы можете размещать текст на сайте сразу после отправки заявки.

## Быстрый старт

``` sh
$ bundle install
$ mv config/config.yml.example config/config.yml
$ vim config/config.yml # выставляем APP_ID и APP_PASSWORD
$ ruby cuckoo.rb

$ open http://localhost:4567/
```
## Использование API

POST-запрос с оригинальным текстом на URL `/hosts/:host_id/original-texts/`.

Пример с использованием `httpie`:

``` sh
$ http -f POST http://localhost:4567/hosts/19964/original-texts original_text="Hello world * 100 times"
```


## Ссылки
* [Авторизация клиента в Yandex API](https://oauth.yandex.ru/)
* [Добавление оригинального текста](http://api.yandex.ru/webmaster/doc/dg/reference/host-original-texts-add.xml)
* [Вопросы и ответы по оригинальным текстам](http://help.yandex.ru/webmaster/authored-texts/faq.xml)
