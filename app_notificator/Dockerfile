# Используем базовый образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы requirements.txt и устанавливаем зависимости
COPY app/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Копируем все содержимое директории app в контейнер
COPY app /app

# Указываем команду для запуска Flask-приложения
CMD ["python", "app/main.py"]
