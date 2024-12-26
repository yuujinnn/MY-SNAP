# Python 이미지를 기반으로 사용 (예: Python 3.10)
FROM python:3.10-slim

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 가상환경 생성 및 활성화 후 의존성 설치
ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV && \
    . $VIRTUAL_ENV/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# 환경 변수 설정
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 애플리케이션 코드 복사
COPY . /app
WORKDIR /app

# 컨테이너 시작 명령어
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]