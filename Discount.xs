#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <string.h>
#include <mkdio.h>

MODULE = Text::Markdown::Discount		PACKAGE = Text::Markdown::Discount	PREFIX = TextMarkdown_

PROTOTYPES: DISABLE

SV *
TextMarkdown__markdown(text)
        char *text;
    PREINIT:
        SV* r = &PL_sv_undef;
        int flags = MKD_NOHEADER|MKD_NOPANTS;
        char *html = NULL;
        int szhtml;
        MMIOT *doc;
    CODE:
        if ( (doc = mkd_string(text, strlen(text), flags)) == 0 ) {
            croak("failed at mkd_string");
        }

        if ( !mkd_compile(doc, flags) ) {
            mkd_cleanup(doc);
            croak("failed at mkd_compile");
        }

        if ( (szhtml = mkd_document(doc, &html)) == EOF ) {;
            mkd_cleanup(doc);
            croak("failed at mkd_document");
        }

        r = newSVpvn(html, szhtml);
        sv_catpv(r, "\n");

        mkd_cleanup(doc);
        RETVAL = r;
    OUTPUT:
        RETVAL
