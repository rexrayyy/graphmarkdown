FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
# Устанавливаем зависимости в локальную папку пользователя
RUN pip install --user -r requirements.txt

FROM python:3.11-slim
WORKDIR /app
# ВАЖНО: здесь должен быть знак "="
COPY --from=builder /root/.local /root/.local
COPY . . 

# Добавляем путь к установленным пакетам в переменную окружения
ENV PATH=/root/.local/bin:$PATH
EXPOSE 5001

CMD ["python", "app.py"]
