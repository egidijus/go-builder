.DEFAULT_GOAL := go
export all
SHELL := /usr/bin/env bash
UID := $(shell id -u -r)
PWD := $(shell pwd)
go : build run

build:
	docker build -t go-builder -f Dockerfile .

run:
	docker run -it --rm -e DO_USER=$(USER) -e DO_UID=$(UID) --rm -v $(PWD)/gowork:/gowork go-builder
	@echo "check gowork for your binaries"
