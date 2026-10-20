TYPST ?= typst

.PHONY: all public interne clean

# Version publique (toujours disponible) + version interne si les fichiers privés sont présents
all: public
	@if [ -f config_interne.typ ]; then $(MAKE) --no-print-directory interne; else echo "(version interne ignorée : config_interne.typ absent)"; fi

public:
	$(TYPST) compile retex.typ RETEX_IA_public.pdf

interne:
	@test -f config_interne.typ || (echo "config_interne.typ absent (fichier privé)"; exit 1)
	$(TYPST) compile --input version=interne retex.typ RETEX_IA_interne.pdf

clean:
	rm -f RETEX_IA_public.pdf RETEX_IA_interne.pdf
