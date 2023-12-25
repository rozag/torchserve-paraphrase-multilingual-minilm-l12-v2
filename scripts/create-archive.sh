#!/bin/bash

rm -rf model_store
mkdir -p model_store

torch-model-archiver \
--model-name paraphrase-multilingual-MiniLM-L12-v2 \
--version 1.0 \
--model-file my_model/pytorch_model.bin \
--handler handler.py  \
--extra-files "my_model/config.json,my_tokenizer/tokenizer.json,my_tokenizer/special_tokens_map.json,my_tokenizer/tokenizer_config.json,my_tokenizer/vocab.txt" \
--export-path model_store
# TODO: adjust extra files!

echo "Archive created!"
