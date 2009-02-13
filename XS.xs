#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <string.h>
#include <mkdio.h>

MODULE = Text::Markdown::XS		PACKAGE = Text::Markdown::XS		

PROTOTYPES: DISABLE

SV *
_markdown(text)
        char *text;
    PREINIT:
        SV* r = &PL_sv_undef;
    CODE:
        int rc;
        int flags = 0x0004;/* TODO handle flags */
        char *ret;
        int szret;
        MMIOT *doc;

        if ( (doc = mkd_string(text, strlen(text), flags)) == 0 ) {
            exit(1);
        }

        mkd_compile(doc, flags);

        if ( (szret = mkd_document(doc, &ret)) != EOF ) {;
            // got segfault (or bus error) with this
            // ignoreing the last invisible char is better than
            // aborting the fatal error
            //strcat(ret, "\n");
        }

        r = newSVpvn(ret, strlen(ret));
        RETVAL = r;
    OUTPUT:
        RETVAL
