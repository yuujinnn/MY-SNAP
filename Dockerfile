# Python 이미지를 기반으로 사용 (예: Python 3.10)
FROM python:3.10-slim

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# 애플리케이션 코드 복사
COPY . /app
WORKDIR /app

# 가상환경 생성
ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV

# pip 업그레이드
RUN $VIRTUAL_ENV/bin/pip install --upgrade pip

# requirements.txt 설치
RUN $VIRTUAL_ENV/bin/pip install -r requirements.txt

# 환경 변수 설정
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# 컨테이너 시작 명령어
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
