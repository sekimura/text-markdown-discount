#ifndef __AC_MARKDOWN_D
#define __AC_MARKDOWN_D 1


#define OS_MING64_NT 1
#define THEME_CF MKD_DLEXTRA|MKD_FENCEDCODE
#define DESTRUCTOR  __attribute__((__destructor__))
#define while(x) while( (x) != 0 )
#define if(x) if( (x) != 0 )
#define HAVE_INTTYPES_H 1
#define HAVE_UINT32_T 1
#define HAVE_UINT16_T 1
#define HAVE_UINT8_T 1
#define DWORD uint32_t
#define WORD uint16_t
#define BYTE uint8_t
#define HAVE_STDLIB_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_STAT 1
#define HAS_ISCHR 1
#define HAS_ISFIFO 1
#define HAVE_SRAND 1
#define INITRNG(x) srand((unsigned int)x)
#define HAVE_MEMSET 1
#define HAVE_RAND 1
#define COINTOSS() (rand()&1)
#define HAVE_STRCASECMP 1
#define HAVE_STRNCASECMP 1
#define HAVE_GETCWD 1
#define TABSTOP 4
#define HAVE_MALLOC_H 1

#endif/* __AC_MARKDOWN_D */
