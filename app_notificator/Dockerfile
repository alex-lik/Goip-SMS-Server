# Используем официальный slim-образ Python
FROM python:3.9-slim

# Устанавливаем переменные окружения
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Создаём рабочую директорию
WORKDIR /app

# Копируем только requirements.txt для кэширования слоёв установки зависимостей
COPY app/requirements.txt ./

# Обновляем pip и устанавливаем зависимости
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Копируем остальное приложение
COPY app/ .

# Указываем команду запуска
CMD ["python", "main.py"]
