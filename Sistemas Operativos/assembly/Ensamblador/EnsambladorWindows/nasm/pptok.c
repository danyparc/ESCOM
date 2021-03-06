/* Automatically generated from ./pptok.dat by ./pptok.pl */
/* Do not edit */

#include "compiler.h"
#include <inttypes.h>
#include <ctype.h>
#include "nasmlib.h"
#include "hashtbl.h"
#include "preproc.h"

const char * const pp_directives[103] = {
    "%elif",
    "%elifn",
    "%elifctx",
    "%elifnctx",
    "%elifdef",
    "%elifndef",
    "%elifempty",
    "%elifnempty",
    "%elifid",
    "%elifnid",
    "%elifidn",
    "%elifnidn",
    "%elifidni",
    "%elifnidni",
    "%elifmacro",
    "%elifnmacro",
    "%elifnum",
    "%elifnnum",
    "%elifstr",
    "%elifnstr",
    "%eliftoken",
    "%elifntoken",
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    "%if",
    "%ifn",
    "%ifctx",
    "%ifnctx",
    "%ifdef",
    "%ifndef",
    "%ifempty",
    "%ifnempty",
    "%ifid",
    "%ifnid",
    "%ifidn",
    "%ifnidn",
    "%ifidni",
    "%ifnidni",
    "%ifmacro",
    "%ifnmacro",
    "%ifnum",
    "%ifnnum",
    "%ifstr",
    "%ifnstr",
    "%iftoken",
    "%ifntoken",
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    "%arg",
    "%assign",
    "%clear",
    "%define",
    "%defstr",
    "%depend",
    "%else",
    "%endif",
    "%endm",
    "%endmacro",
    "%endrep",
    "%error",
    "%exitrep",
    "%fatal",
    "%iassign",
    "%idefine",
    "%idefstr",
    "%imacro",
    "%include",
    "%ixdefine",
    "%line",
    "%local",
    "%macro",
    "%pathsearch",
    "%pop",
    "%push",
    "%rep",
    "%repl",
    "%rotate",
    "%stacksize",
    "%strcat",
    "%strlen",
    "%substr",
    "%undef",
    "%unimacro",
    "%unmacro",
    "%use",
    "%warning",
    "%xdefine",
};
const uint8_t pp_directives_len[103] = {
    5,
    6,
    8,
    9,
    8,
    9,
    10,
    11,
    7,
    8,
    8,
    9,
    9,
    10,
    10,
    11,
    8,
    9,
    8,
    9,
    10,
    11,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    3,
    4,
    6,
    7,
    6,
    7,
    8,
    9,
    5,
    6,
    6,
    7,
    7,
    8,
    8,
    9,
    6,
    7,
    6,
    7,
    8,
    9,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    4,
    7,
    6,
    7,
    7,
    7,
    5,
    6,
    5,
    9,
    7,
    6,
    8,
    6,
    8,
    8,
    8,
    7,
    8,
    9,
    5,
    6,
    6,
    11,
    4,
    5,
    4,
    5,
    7,
    10,
    7,
    7,
    7,
    6,
    9,
    8,
    4,
    8,
    8,
};
enum preproc_token pp_token_hash(const char *token)
{
#define UNUSED 16383
    static const int16_t hash1[128] = {
        UNUSED,
        UNUSED,
        0,
        0,
        0,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        0,
        0,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        0,
        -47,
        UNUSED,
        0,
        UNUSED,
        -60,
        0,
        UNUSED,
        UNUSED,
        -44,
        UNUSED,
        UNUSED,
        -45,
        UNUSED,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        46,
        UNUSED,
        UNUSED,
        47,
        5,
        UNUSED,
        -49,
        65,
        UNUSED,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        38,
        UNUSED,
        26,
        0,
        UNUSED,
        6,
        35,
        UNUSED,
        UNUSED,
        UNUSED,
        38,
        UNUSED,
        125,
        UNUSED,
        0,
        UNUSED,
        36,
        15,
        0,
        120,
        -81,
        UNUSED,
        UNUSED,
        80,
        0,
        UNUSED,
        14,
        92,
        -60,
        -102,
        0,
        -12,
        -73,
        UNUSED,
        UNUSED,
        UNUSED,
        1,
        UNUSED,
        0,
        10,
        UNUSED,
        -141,
        UNUSED,
        100,
        UNUSED,
        77,
        UNUSED,
        41,
        82,
        UNUSED,
        19,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        9,
        87,
        -1,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        101,
        42,
        UNUSED,
    };
    static const int16_t hash2[128] = {
        UNUSED,
        0,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        0,
        81,
        UNUSED,
        64,
        UNUSED,
        0,
        UNUSED,
        0,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        64,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        0,
        121,
        0,
        UNUSED,
        15,
        94,
        63,
        UNUSED,
        114,
        UNUSED,
        178,
        UNUSED,
        UNUSED,
        UNUSED,
        0,
        UNUSED,
        -34,
        UNUSED,
        84,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        83,
        UNUSED,
        40,
        UNUSED,
        UNUSED,
        139,
        UNUSED,
        UNUSED,
        UNUSED,
        97,
        UNUSED,
        44,
        100,
        145,
        UNUSED,
        21,
        51,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        0,
        UNUSED,
        UNUSED,
        UNUSED,
        33,
        0,
        0,
        88,
        UNUSED,
        48,
        71,
        UNUSED,
        7,
        37,
        60,
        UNUSED,
        UNUSED,
        109,
        50,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        UNUSED,
        93,
        95,
        70,
        UNUSED,
        16,
        63,
        32,
        UNUSED,
        UNUSED,
        UNUSED,
        8,
        11,
        81,
        UNUSED,
        UNUSED,
        37,
        UNUSED,
        8,
        18,
        UNUSED,
        UNUSED,
        74,
        92,
        UNUSED,
    };
    uint32_t k1, k2;
    uint64_t crc;
    uint16_t ix;

    crc = crc64i(UINT64_C(0xaee7ac5ccabdec91), token);
    k1 = (uint32_t)crc;
    k2 = (uint32_t)(crc >> 32);

    ix = hash1[k1 & 0x7f] + hash2[k2 & 0x7f];
    if (ix >= 103)
        return PP_INVALID;

    if (!pp_directives[ix] || nasm_stricmp(pp_directives[ix], token))
        return PP_INVALID;

    return ix;
}
