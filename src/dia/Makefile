
DIAGRAMS := $(patsubst %.dia,%.eps,$(wildcard *.dia))

eps-export: $(DIAGRAMS)

%.eps: %.dia
	dia -e $@ $^

clean: 
	rm -f $(DIAGRAMS)


