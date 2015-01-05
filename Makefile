MAINCLASS:=sample.SampleVerticle
NAME:=vertx-mirah-sample
VERSION:=1.0.0

ETCDIR=etc
SRCDIR=src
CLASSPATH:=$(SRCDIR)
BUILDDIR=build
LOCALCONFIG=Makefile.local

ifeq ($(LOCALCONFIG), $(wildcard $(LOCALCONFIG)))
include $(LOCALCONFIG)
endif

CLASSDIR=$(BUILDDIR)/classes
CLASSPATH:=$(CLASSPATH):$(CLASSDIR)
SRCS=$(shell find $(SRCDIR) -name *.mirah)
OBJS=$(patsubst $(SRCDIR)%,$(CLASSDIR)%,$(patsubst %.mirah,%.class,$(SRCS)))
TARGET:=$(BUILDDIR)/$(NAME)-$(VERSION).zip
ORIGINTARGET:=$(BUILDDIR)/$(NAME)-$(VERSION)-origin.zip

vpath %.mirah $(SRCDIR)
vpath %.class $(BUILDDIR)

all: check | $(OBJS)

mod: check | $(TARGET)

check:
ifneq ($(LOCALCONFIG), $(wildcard $(LOCALCONFIG)))
	@echo "Makefile.local not found"
	exit -1
endif

prebuild:
ifeq "$(wildcard $(BUILDDIR))" ""
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(CLASSDIR)
endif

proguard: $(ORIGINTARGET)
	java -jar $(PROGUARD) -injars $(ORIGINTARGET) -outjars $(BUILDDIR)/tmp.zip -libraryjars $(CLASSPATH):$(RT) -keep "public class $(MAINCLASS) { public void start(); }" -optimizationpasses 3 -printmapping mapping.txt
	unzip $(BUILDDIR)/tmp.zip -d $(BUILDDIR)/tmp
	jar cvf $(TARGET) -C $(BUILDDIR)/tmp/ .
	rm -rf $(BUILDDIR)/tmp
	rm $(BUILDDIR)/tmp.zip

$(TARGET): proguard

$(ORIGINTARGET):$(OBJS) $(ETCDIR)/mod.json
	cp $(ETCDIR)/mod.json $(BUILDDIR)/classes/
	jar cvf $(ORIGINTARGET) -C $(BUILDDIR)/classes/ .

$(OBJS): $(SRCS) | prebuild
	mirahc --cp $(CLASSPATH) --new-closures --dest build/classes $(SRCS)

clean:
	rm -rf $(BUILDDIR)

.PHONY: all mod check prebuild proguard clean
