#!/usr/bin/env bash
docker pull registry.kubernetes.ch/silvermind/artefact_docs:master-latest
docker tag registry.kubernetes.ch/silvermind/artefact_docs:master-latest silvermind/artefact_docs:master-latest
docker push silvermind/artefact_docs