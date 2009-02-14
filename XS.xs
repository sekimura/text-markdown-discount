#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <string.h>
#include <mkdio.h>

MODULE = Text::Markdown::XS		PACKAGE = Text::Markdown::XS	PREFIX = TextMarkdown_

PROTOTYPES: DISABLE

SV *
TextMarkdown_markdown(text)
        char *text;
    PREINIT:
        SV* r = &PL_sv_undef;
        int flags = MKD_NOHEADER|MKD_NOPANTS;
        char *ret;
        STRLEN szret;
        MMIOT *doc;
    CODE:
        if ( (doc = mkd_string(text, strlen(text), flags)) == 0 ) {
            croak("failed at mkd_string");
        }

        if ( !mkd_compile(doc, flags) ) {
            croak("failed at mkd_compile");
        }

        if ( (szret = mkd_document(doc, &ret)) != EOF ) {;
            /* Got segfault (or bus error) with this.
            /  missing the last invisible char, line feed, is better than
            /  getting the fatal error
            */
            // strcat(ret, "\n");
        } else {
            croak("failed at mkd_document");
        }

        r = newSVpvn(ret, strlen(ret));

        Safefree(ret);
        Safefree(doc);
        RETVAL = r;
    OUTPUT:
        RETVAL
