LATEST_VERSION = 1.12
VERSIONS = $(notdir $(shell find versions -mindepth 1 -maxdepth 1 -type d))

LATEST_DEBIAN = debian-stretch
LATEST_UBUNTU = ubuntu-cosmic
OSES = debian-stretch ubuntu-bionic ubuntu-cosmic

ALL_TARGETS =

ALL_TAGS =

all:

define DOCKER_TEMPLATE =
v$(1)-$(2):: versions/$(1)/$(2)/Dockerfile
	docker build -t daewok/ccl:$(1)-$(2) versions/$(1)/$(2)

ALL_TARGETS += v$(1)-$(2)
ALL_TAGS += $(1)-$(2)
.PHONY: v$(1)-$(2)
endef

define LATEST_DEBIAN_TEMPLATE =
v$(1)-debian: v$(1)-$(LATEST_DEBIAN)
	docker tag daewok/ccl:$(1)-$(LATEST_DEBIAN) daewok/ccl:$(1)-debian

ALL_TARGETS += v$(1)-debian
ALL_TAGS += $(1)-debian
.PHONY: v$(1)-debian
endef

define LATEST_UBUNTU_TEMPLATE =
v$(1)-ubuntu: v$(1)-$(LATEST_UBUNTU)
	docker tag daewok/ccl:$(1)-$(LATEST_UBUNTU) daewok/ccl:$(1)-ubuntu

ALL_TARGETS += v$(1)-ubuntu
ALL_TAGS += $(1)-ubuntu
.PHONY: v$(1)-ubuntu
endef

define EXPAND_VERSION =
$(foreach os,$(OSES),$(eval $(call DOCKER_TEMPLATE,$(1),$(os))))

$(eval $(call LATEST_DEBIAN_TEMPLATE,$(1)))
$(eval $(call LATEST_UBUNTU_TEMPLATE,$(1)))

endef


define EXPAND_OS =
$(1): v$(LATEST_VERSION)-$(1)
	docker tag daewok/ccl:$(LATEST_VERSION)-$(1) daewok/ccl:$(1)

.PHONY: $(1)

ALL_TARGETS += $(1)
ALL_TAGS += $(1)
endef

$(foreach v,$(VERSIONS),$(call EXPAND_VERSION,$(v)))
$(foreach o,$(OSES),$(eval $(call EXPAND_OS,$(o))))

debian-latest: v$(LATEST_VERSION)-$(LATEST_DEBIAN)
	docker tag daewok/ccl:$(LATEST_VERSION)-$(LATEST_DEBIAN) daewok/ccl:debian

ubuntu-latest: v$(LATEST_VERSION)-$(LATEST_UBUNTU)
	docker tag daewok/ccl:$(LATEST_VERSION)-$(LATEST_UBUNTU) daewok/ccl:ubuntu

latest: debian-latest
	docker tag daewok/ccl:debian daewok/ccl:latest

ALL_TAGS += debian ubuntu latest

all: debian-latest ubuntu-latest latest $(ALL_TARGETS)

all_tags:
	@echo $(ALL_TAGS)

push: all
	for tag in $(ALL_TAGS) ; do \
		docker push daewok/ccl:$$tag ; \
	done

.PHONY: all all_tags latest push
