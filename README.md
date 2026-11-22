# devops-ci-app

Практика 10. Flask отвечает на `/` и `/health`. GitHub Actions последовательно
проверяет исходники, запускает pytest, собирает образ и делает smoke-test.
После успешного push в main один образ получает два тега в GHCR.

```bash
python -m pip install -r app/requirements.txt -r requirements-dev.txt
python -m pylint app --score=no
python -m pytest -q
```
