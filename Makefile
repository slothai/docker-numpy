build:
	docker build --tag slothai/numpy:dev .
debug:
	docker run -it slothai/numpy:dev /bin/sh
