# devops-ci-app

Практика 10. Flask отвечает на `/` и `/health`. GitHub Actions последовательно
проверяет исходники, запускает pytest, собирает образ и делает smoke-test.
После успешного push в main один образ получает два тега в GHCR.

```bash
python -m pip install -r app/requirements.txt -r requirements-dev.txt
python -m pylint app --score=no
python -m pytest -q
```

## Проверка опубликованного образа

Возьмите полный SHA последнего успешного запуска в `main`.

```bash
image=ghcr.io/shxvier/devops-ci-app
read -r sha
docker pull "$image:$sha"
docker run --rm -d --name ci-app-sha -p 127.0.0.1:5002:5000 "$image:$sha"
curl --fail http://127.0.0.1:5002/health
docker exec ci-app-sha id
docker stop ci-app-sha
```

Ожидаются HTTP 200, JSON `{"status":"ok"}` и пользователь `app`.
