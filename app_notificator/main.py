from flask import Flask, request, jsonify
from loguru import logger
from dotenv import load_dotenv
import pymysql
import requests
import os
import sys

# Загрузка .env
load_dotenv()

# Валидация ключевых переменных
REQUIRED_ENV = ["DB_HOST", "DB_PORT", "DB_USER", "DB_PASSWORD", "DB_NAME"]
for var in REQUIRED_ENV:
    if not os.getenv(var):
        logger.error(f"ENV переменная {var} не установлена")
        sys.exit(1)

# Настройка логов
logger.add('./logs/log.log', rotation='1 day', retention='30 days')

app = Flask(__name__)
session = requests.Session()


def get_db_connection():
    return pymysql.connect(
        host=os.getenv('DB_HOST'),
        port=int(os.getenv('DB_PORT')),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        db=os.getenv('DB_NAME')
    )


def get_provider(card_name):
    try:
        with get_db_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT prov.prov
                    FROM goip
                    JOIN prov ON goip.provider = prov.id
                    WHERE goip.name = %s
                """, (card_name,))
                row = cursor.fetchone()
                return row[0] if row else None
    except Exception as e:
        logger.exception("Ошибка при получении провайдера")
        return None


def get_tg_settings(provider):
    token = os.getenv(f'TG_TOKEN_{provider}')
    chat_id = os.getenv(f'TG_CHAT_ID_{provider}')
    if not all([token, chat_id]):
        logger.error(f"Не найдены переменные TG_TOKEN_{provider} и/или TG_CHAT_ID_{provider}")
        return None
    return token, chat_id


def make_message(card_name, send_number, text):
    return f'Получатель: {card_name}\nОтправитель: {send_number}\nСообщение: {text}'


def send_message(card_name, message):
    provider = get_provider(card_name)
    if not provider:
        logger.error("Не удалось определить провайдера для карты")
        return

    tg_data = get_tg_settings(provider)
    if not tg_data:
        return

    token, chat_id = tg_data
    url = f"https://api.telegram.org/bot{token}/sendMessage"
    try:
        response = session.post(url, json={
            'chat_id': chat_id,
            'text': message
        }, timeout=10)
        logger.info(f"Telegram ответ: {response.status_code}")
    except requests.RequestException as e:
        logger.exception("Ошибка при отправке сообщения в Telegram")


@app.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'Сервис работает'})


@app.route('/', methods=['POST'])
def handle_post():
    try:
        data = request.get_json() if request.is_json else request.form.to_dict()
        logger.info(f"Получены данные: {data}")

        card_name = data.get('name')
        number = data.get('number')
        text = data.get('content')

        if not all([card_name, number, text]):
            return jsonify({'error': 'Некорректные данные'}), 400

        msg = make_message(card_name, number, text)
        send_message(card_name, msg)
        return jsonify({'message': 'Обработано'}), 200
    except Exception as e:
        logger.exception("Ошибка обработки запроса")
        return jsonify({'error': 'Ошибка сервиса'}), 500


if __name__ == '__main__':
    port = int(os.getenv("PORT", 5000))
    app.run(debug=True, host='0.0.0.0', port=port)
