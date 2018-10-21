#!/usr/bin/env bash
docker pull registry.kubernetes.ch/silvermind/artefact_docs:master-latest-docs
docker tag registry.kubernetes.ch/silvermind/artefact_docs:master-latest-docs silvermind/artefact_docs:latest
docker push silvermind/artefact_docs