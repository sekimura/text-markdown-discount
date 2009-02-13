#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "cstring.h"
#include "markdown.h"

typedef struct {
        char sym;
        char * xml_sym;
} e_char;



MODULE = Text::Markdown::XS		PACKAGE = Text::Markdown::XS		

SV *
_markdown(text)
        char *text;
    PREINIT:
        SV* r = &PL_sv_undef;
    CODE:
        int rc;
        int flags = 0x0004;
        char *ret;
        int szret;
        Document *doc;
        if ( (doc = mkd_string(text, strlen(text), flags)) == 0 ) {
            exit(1);
        }
        mkd_compile(doc, flags);
        szret = mkd_document(doc, &ret);

        r = newSVpv(ret, 0);
        RETVAL = r;
    OUTPUT:
        RETVAL
