Задача:
Написать конфигурацию для docker-compose с one-shot сервисом (bash/curl или python или любой предпочитаемый язык), который позволяет после старта сервиса elasticsearch предзаполнить произвольный индекс из json файла, либо через snapshot restore.

Решение:
1. Нужен elasticsearch к которому будет потключаться one-shot сервис.

  docker pull docker.elastic.co/elasticsearch/elasticsearch:7.6.0
  docker run -p 9200:9200 -d --name es -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.6.0

2. Второй этап подготовки:
    # Создаем несколько json файлов для тестирования. Проверяем валидатором, что файлы не имеют синтаксических ошибок.
    # Создаем скрипт, который будет производить подготовку файлов в нужный фортма.

3. Запуск.
