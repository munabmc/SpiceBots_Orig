TARGETS = all clean
.PHONY: $(TARGETS)

#BOOST_INCLUDE_DIRS=-I/usr/local/boost_1_43_0 -I/opt/local/include -I/usr/local/include
BOOST_INCLUDE_DIRS=
INCLUDES=

ifndef OSTYPE
  OSTYPE = $(shell uname -s|awk '{print tolower($$0)}')
  #export OSTYPE
endif

ifeq ($(OSTYPE),linux)
  SHLIBEXT=so
  MEXEXT=mexglx
  LIBRT=-lrt
endif
ifeq ($(OSTYPE),darwin)
  SHLIBEXT=dylib
  MEXEXT=mexmaci
  INCLUDES=-I/usr/include
endif

all: naoComm monitorComm time mexshm

naoComm: naoComm.cc
	mex -O $^ $(INCLUDES)

monitorComm: monitorComm.cc
	gcc -c libMonitor.cc
#	mex -v -O $^ libMonitor.o -I/usr/include
	mex -O $^ libMonitor.o $(INCLUDES)


time: time.cc timeScalar.cc
	mex -O $^ $(BOOST_INCLUDE_DIRS) $(LIBRT)

mexshm: mexshm.cpp
	mex -O $^ $(BOOST_INCLUDE_DIRS) $(LIBRT)

clean:
	rm -f *.o
	rm -f *.$(MEXEXT)
