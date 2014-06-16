
DIAGRAMS := $(patsubst %.dia,%.png,$(wildcard *.dia))

png-export: $(DIAGRAMS)

%.png: %.dia
	dia -e $@ -t png-libart $^

clean: 
	rm -f $(DIAGRAMS)


