CC=gcc
CFLAGS=-I
DEPS=featex.c
PS=/usr/local/include/pocketsphinx
SB=/usr/local/include/sphinxbase
LPS=pocketsphinx/src/libpocketsphinx

featex: $(DEPS)
	$(CC) $(CFLAGS) ${PS} $(CFLAGS) $(SB) \
    $(CFLAGS) $(LPS)\
    -o $@ $^ -lpocketsphinx -lsphinxbase -lm
