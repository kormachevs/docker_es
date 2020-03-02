Задача:
Написать конфигурацию для docker-compose с one-shot сервисом (bash/curl или python или любой предпочитаемый язык), который позволяет после старта сервиса elasticsearch предзаполнить произвольный индекс из json файла, либо через snapshot restore.

Решение:
# 1. Нужен elasticsearch к которому будет подключаться one-shot сервис.
---
    docker pull docker.elastic.co/elasticsearch/elasticsearch:7.6.0

    docker run -p 9200:9200 -d --name es -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.6.0
---
# 2. Второй этап подготовки:
    * Создаем несколько json файлов для тестирования. Проверяем валидатором, что файлы не имеют синтаксических ошибок.
    * Создаем скрипт, который будет производить подготовку файлов в нужный форма.

# 3. Запуск.
    *Необходимо поправить значение переменной ESDOMAIN=es, где es - доменное имя или IP на котором запущен сервис es.
    *docker-compose up

В результате будут созданы и заполнены индексы, где имя индекса = имя_файла.

Н-р: в каталоге json-file лежат всего 2 файла(first.json, second.json), будут заполнены индексы fist, second.
