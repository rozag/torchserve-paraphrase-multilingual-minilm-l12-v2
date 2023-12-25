build-archive:
	python dump_model.py
	./scripts/create-archive.sh

build-docker:
	docker build -t torchserve-paraphrase-multilingual-minilm-l12-v2 .

serve: build-archive
	bash ./scripts/start-torchserve.sh


.PHONY: test
