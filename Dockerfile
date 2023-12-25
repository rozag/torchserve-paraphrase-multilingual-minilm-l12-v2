# NOTE: we might want to use a -gpu image later
ARG TORCHSERVE_VERSION=0.9.0-cpu

# Builder image
FROM pytorch/torchserve:${TORCHSERVE_VERSION} AS builder

WORKDIR /usr/app
ADD requirements.txt .
RUN pip install -r requirements.txt

ADD dump_model.py .
RUN python dump_model.py

# TODO: remove
RUN ls -la
RUN ls -la my_model

ADD handler.py .
ADD scripts/create-archive.sh scripts/create-archive.sh

RUN ./scripts/create-archive.sh

# TODO: remove
RUN ls -la
RUN ls -la model_store

# Production image
FROM pytorch/torchserve:${TORCHSERVE_VERSION}

ADD requirements.txt .
RUN pip install -r requirements.txt

ADD docker/entrypoint.sh entrypoint.sh
ADD scripts/start-torchserve.sh start-torchserve.sh

# TODO: remove
RUN ls -la

COPY --from=builder /usr/app/model_store model_store

# TODO: remove
RUN ls -la
RUN ls -la model_store

ENTRYPOINT [ "./entrypoint.sh" ]

CMD ["./start-torchserve.sh"]
