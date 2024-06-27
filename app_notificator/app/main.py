from flask import Flask, request, jsonify
from loguru import logger
import pymysql
import requests
from dotenv import load_dotenv
import os

# Загрузка переменных окружения из файла .env
load_dotenv()

logger.add('./logs/log.log', rotation='1 day', retention='30 days')

app = Flask(__name__)


def get_taxi(card_name):
    """ Функция для получения такси """
    connection = pymysql.connect(
        host=os.getenv('DB_HOST'), 
        port=int(os.getenv('DB_PORT')), 
        user=os.getenv('DB_USER'), 
        password=os.getenv('DB_PASSWORD'),
        db=os.getenv('DB_NAME')
    )
    try:
        with connection.cursor() as cursor:
            sql = """
                SELECT prov.prov 
                FROM goip 
                JOIN prov ON goip.provider = prov.id 
                WHERE goip.name = %s
            """
            cursor.execute(sql, (card_name,))
            result = cursor.fetchone()
            return result[0] if result else None
    except Exception as e:
        logger.error(f"Ошибка выполнения запроса: {e}")
        return None
    finally:
        connection.close()


def get_tg_settings(taxi):
    """ Функция для получения настроек Telegram """
    if taxi == 'Fly':
        return os.getenv('TG_TOKEN_FLY'), os.getenv('TG_CHAT_ID_FLY')
    elif taxi == 'Jet':
        return os.getenv('TG_TOKEN_JET'), os.getenv('TG_CHAT_ID_JET')
    else:
        return None


def make_message(card_name, send_number, text):
    """ Функция для создания сообщения """
    return f'Получатель: {card_name}\nОтправитель: {send_number}\nСообщение: {text}'


def send_message(card_name, message):
    """ Функция для отправки сообщения """
    taxi = get_taxi(card_name)
    if not taxi:
        logger.error("Не удалось определить такси")
        return
    tg_data = get_tg_settings(taxi)
    if not tg_data:
        logger.error("Не удалось получить данные для Telegram")
        return

    token, chat_id = tg_data
    url_req = f"https://api.telegram.org/bot{token}/sendMessage?chat_id={chat_id}&text={message}"
    try:
        response = requests.get(url_req)
        logger.info(f"Ответ Telegram API: {response.status_code}")
    except requests.RequestException as e:
        logger.error(f"Ошибка отправки сообщения в Telegram: {e}")

@app.route('/', methods=['GET'])
def index():
    return {'message':'service is work'}
@app.route('/', methods=['POST'])
def handle_post():
    """ Обработка POST-запросов от шлюзов GOIP """
    try:
        data = request.get_json() if request.is_json else request.form.to_dict()
        logger.info(f"Получены данные: {data}")

        card_name = data.get('name')
        number = data.get('number')
        text = data.get('content')

        if not all([card_name, number, text]):
            return jsonify({'error': 'Некорректные данные'}), 400

        message = make_message(card_name, number, text)
        send_message(card_name, message)
        return jsonify({'message': 'Данные получены и обработаны!'}), 200
    except Exception as e:
        logger.error(f"Ошибка обработки запроса: {e}")
        return jsonify({'error': 'Ошибка обработки данных!'}), 500


def test():
    card_name = 'LIFE_1'
    number = '0632079737'
    text = 'Тест\n123\n456'
    message = make_message(card_name, number, text)
    send_message(card_name, message)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
    # test()
