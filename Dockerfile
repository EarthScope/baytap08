#Dockerfile for baytap08

# Build baytap08 
FROM centos:7 AS compile-baytap
  
RUN yum -y upgrade \
    && yum -y group install "Development Tools" \
    && yum -y install wget vim

WORKDIR /opt

# Download the program and modify the makefile to run/compile
RUN cd /opt/ \
    && wget https://igppweb.ucsd.edu/~agnew/Baytap/baytap08.tar.gz \
    && tar -xzf baytap08.tar.gz \
    && rm baytap08.tar.gz \
    && cd baytap08/src/ \
    && echo "BIN=../bin/" >> tempfile \
    && echo " " >> tempfile \
    && echo "FTN = gfortran" >> tempfile \
    && echo " " >> tempfile \
    && echo "FFLAGS = -O2  -Wunused -Wno-globals -fno-f2c -fno-automatic -fno-backslash" >> tempfile \
    && echo " " >> tempfile \
    && echo "baytap08: baytap08.f" >> tempfile \
    && echo -e "\t\$(FTN) \$(FFLAGS) baytap08.f -o \$(BIN)baytap08" >> tempfile \
    && mv tempfile makefile \
    && make

# Add baytap to path
ENV PATH="/opt/baytap08/bin:${PATH}"

