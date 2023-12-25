#!/bin/bash

# --ncs means the snapshot feature is disabled.

echo "server is starting..."
torchserve --foreground --model-store model_store --models my_model=paraphrase-multilingual-MiniLM-L12-v2.mar --ncs
