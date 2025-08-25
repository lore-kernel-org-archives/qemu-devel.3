Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4176BCA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 07:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRYA-0003Q1-EF; Mon, 25 Aug 2025 03:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRXw-0003PA-Ge
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:23:16 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqRXq-0001fI-PY
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:23:15 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61c30ceacdcso2949161a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756106586; x=1756711386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u45ykrYkuCt/hD79fRrYiLNYCDS/5E2/xpZe84aiaXo=;
 b=NFqW6AGN90beFT322E9/AuQKjmBWi/c7fxWBecIP94X0Gb+xAYKrwTy4FPtlYb7pN8
 08pMhlVGf/BE/Hb/O6lBFXlFlyL2KwZk2mpGhmOQp7l0TkXEO+YOXpkxf3k31rL8vSR0
 NJnunpX0IUFzjUsg9L7dNkVpNCG28sCnqZt1XLUPePTO0+gHG4SOgufoI0fJS0UDo12m
 zktpEXCdRjLUUyb0ta+XjQ/G+dFhZMzprNfzFvhdjwxiA1mBvhplcIpRpWv3F7zA38mL
 QyUDbuheug6vgyFLVe1Wt1bZxllOLxn7x1aOA6SxmNda9iMAJJdl9B5UOCbrg9O2fv2L
 R5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756106586; x=1756711386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u45ykrYkuCt/hD79fRrYiLNYCDS/5E2/xpZe84aiaXo=;
 b=hzTph1Im7JEaj7eLk4NH8Gu5Vah6HjoCMGVdYeiKK+EkoSGsPweQoDhXNrc4sKYWTJ
 UYQKT/zCyGfs7QSRS6NlN/e2nWmBWOUyTvr8jX0u0xsUAqYmozpaNlGRi3jqdEdWATFh
 odei2RI8HRE8RRQ1kmAuUkKMq6emCJlWOQWbGTnGNC6/kKtSXlXr4uCrIZ7Ab6K8og+/
 nBK2UGVWPAdx78cWXE121fPi/54664b2QA7ZJfHGf9NXr/yDn1mjvLGy0Ru4zzrWagOY
 3z8grpaTe66tsJOLBWkBu/mn6tGO5tlcDhz3w+rHjW3imnZbj8FHpqAuCcahd+hcxTnh
 hEyA==
X-Gm-Message-State: AOJu0YxiQSuxXzIkcGq5YnlukcICmCBptF2g8YVAYf6O798FrgTAix01
 2YOYtUUy5mMQQKA4cdIrRWgTz6Hl1/RAb4WP/KlnGkJxkeeoCXtP3vfzXdNYJKTDZJ5lboXS+Bl
 bSLhXpZMVmpcIvhxrjrpUcSpEXzN1ecNIGsuBMsBTXzYKhp2BTWm0R88=
X-Gm-Gg: ASbGncvnGCasbZqZ49kfzLFMB7aFc0l4B1oacZklb5UwQErJdjqmco/as+XplzxB3Tb
 u7PaQuLXUipXBP/13ovEZhbG53ha83SJXCfmMpOg/IvvOgxmMSLZegjJFWbISlvPa1ByhQ8mAQm
 bm2M3467d9dTMp+HCskwTNku5eT2pwILmTMHgogzr8hx2cz0r0ccjOldTO2o1sa61+shiFA3g5V
 8dXlyKH
X-Google-Smtp-Source: AGHT+IH9trGN2jhuQ7DnhbBllVkBRoB+E/61nbb8hnN8AqLzTMhtk5aP9wLoRd5WJS/5Gd5UvzjSVaAd95INgQbHbeA=
X-Received: by 2002:a05:6402:1ec2:b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-61c1b217c7emr11139766a12.18.1756106586231; Mon, 25 Aug 2025
 00:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-7-pbonzini@redhat.com>
In-Reply-To: <20250822122655.1353197-7-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 10:22:40 +0300
X-Gm-Features: Ac12FXwM68nDkVjklxtTH9q-Wj13DjQ0q0MlbqJZFcozY_WU0O0XpBISahvNlZU
Message-ID: <CAAjaMXYC37Ti-M=DcBKvuqoG03ZfW29qbhT3dPH7y6FYYAaQPw@mail.gmail.com>
Subject: Re: [PATCH 06/14] tracetool: Add Rust format support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com, 
 berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 22, 2025 at 3:31=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: Tanish Desai <tanishdesai37@gmail.com>
>
> Generating .rs files makes it possible to support tracing in rust.
> This support comprises a new format, and common code that converts
> the C expressions in trace-events to Rust.  In particular, types
> need to be converted, and PRI macros expanded.  Fortunately, all
> common platforms have a known mapping of 8/16/32/64-bit integers
> to char/short/int/"long long": even if int64_t is equal to long,
> it is fine to change the format string from PRIx64's expansion
> "%lx" to "%llx".  This makes it possible to have a static mapping
> from PRI macros to their expansion.
>
> As of this commit no backend generates Rust code, but it is already
> possible to use tracetool to generate Rust sources; they are not
> functional but they compile and contain tracepoint functions.
>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> [Move Rust argument conversion from Event to Arguments; string
>  support. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py  | 156 +++++++++++++++++++++++++++++++++
>  scripts/tracetool/format/rs.py |  76 ++++++++++++++++
>  2 files changed, 232 insertions(+)
>  create mode 100644 scripts/tracetool/format/rs.py
>
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
> index 1d5238a0843..0b8ec707332 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -31,6 +31,49 @@ def error(*lines):
>      error_write(*lines)
>      sys.exit(1)
>
> +FMT_TOKEN =3D re.compile(r'''(?:
> +                       " ( (?: [^"\\] | \\[\\"abfnrt] |            # a s=
tring literal
> +                               \\x[0-9a-fA-F][0-9a-fA-F]) *? ) "
> +                       | ( PRI [duixX] (?:8|16|32|64|PTR|MAX) )    # a P=
RIxxx macro
> +                       | \s+                                       # spa=
ces (ignored)
> +                       )''', re.X)
> +
> +PRI_SIZE_MAP =3D {
> +    '8':  'hh',
> +    '16': 'h',
> +    '32': '',
> +    '64': 'll',
> +    'PTR': 't',
> +    'MAX': 'j',
> +}
> +
> +def expand_format_string(c_fmt, prefix=3D""):
> +    def pri_macro_to_fmt(pri_macro):
> +        assert pri_macro.startswith("PRI")
> +        fmt_type =3D pri_macro[3]  # 'd', 'i', 'u', or 'x'
> +        fmt_size =3D pri_macro[4:]  # '8', '16', '32', '64', 'PTR', 'MAX=
'
> +
> +        size =3D PRI_SIZE_MAP.get(fmt_size, None)
> +        if size is None:
> +            raise Exception(f"unknown macro {pri_macro}")
> +        return size + fmt_type
> +
> +    result =3D prefix
> +    pos =3D 0
> +    while pos < len(c_fmt):
> +        m =3D FMT_TOKEN.match(c_fmt, pos)
> +        if not m:
> +            print("No match at position", pos, ":", repr(c_fmt[pos:]), f=
ile=3Dsys.stderr)
> +            raise Exception("syntax error in trace file")
> +        if m[1]:
> +            substr =3D m[1]
> +        elif m[2]:
> +            substr =3D pri_macro_to_fmt(m[2])
> +        else:
> +            substr =3D ""
> +        result +=3D substr
> +        pos =3D m.end()
> +    return result
>
>  out_lineno =3D 1
>  out_filename =3D '<none>'
> @@ -90,6 +133,48 @@ def out(*lines, **kwargs):
>      "ptrdiff_t",
>  ]
>
> +C_TYPE_KEYWORDS =3D {"int", "short", "long", "unsigned", "char"}
> +
> +C_TO_RUST_TYPE_MAP =3D {
> +    "int": "std::ffi::c_int",
> +    "long": "std::ffi::c_long",
> +    "long long": "std::ffi::c_longlong",
> +    "short": "std::ffi::c_short",
> +    "char": "std::ffi::c_char",
> +    "bool": "bool",
> +    "unsigned": "std::ffi::c_uint",
> +    "unsigned long": "std::ffi::c_long",
> +    "unsigned long long": "std::ffi::c_ulonglong",
> +    "unsigned short": "std::ffi::c_ushort",
> +    "unsigned char": "u8",
> +    "int8_t": "i8",
> +    "uint8_t": "u8",
> +    "int16_t": "i16",
> +    "uint16_t": "u16",
> +    "int32_t": "i32",
> +    "uint32_t": "u32",
> +    "int64_t": "i64",
> +    "uint64_t": "u64",
> +    "void": "()",
> +    "size_t": "usize",
> +    "ssize_t": "isize",
> +    "uintptr_t": "usize",
> +    "ptrdiff_t": "isize",
> +}
> +
> +# Rust requires manual casting of <32-bit types when passing them to
> +# variable-argument functions.
> +RUST_VARARGS_SMALL_TYPES =3D {
> +    "std::ffi::c_short",
> +    "std::ffi::c_ushort",
> +    "std::ffi::c_char",
> +    "i8",
> +    "u8",
> +    "i16",
> +    "u16",
> +    "bool",
> +}
> +
>  def validate_type(name):
>      bits =3D name.split(" ")
>      for bit in bits:
> @@ -105,6 +190,40 @@ def validate_type(name):
>                               "other complex pointer types should be "
>                               "declared as 'void *'" % name)
>
> +def c_type_to_rust(name):
> +    ptr =3D False
> +    const =3D False
> +    name =3D name.rstrip()
> +    if name[-1] =3D=3D '*':
> +        name =3D name[:-1].rstrip()
> +        ptr =3D True
> +        if name[-1] =3D=3D '*':
> +            # pointers to pointers are the same as void*
> +            name =3D "void"
> +
> +    bits =3D iter(name.split())
> +    bit =3D next(bits)
> +    if bit =3D=3D "const":
> +        const =3D True
> +        bit =3D next(bits)
> +
> +    if bit in C_TYPE_KEYWORDS:
> +        if bit =3D=3D 'signed':
> +            bit =3D ''
> +        rest =3D list(bits)
> +        if rest and rest[-1] =3D=3D 'int':
> +            rest =3D rest[:-1]
> +        name =3D bit + ' ' + ' '.join(rest)
> +    else:
> +        if list(bits):
> +            raise ValueError("Invalid type '%s'." % name)
> +        name =3D bit
> +
> +    ty =3D C_TO_RUST_TYPE_MAP[name.strip()]
> +    if ptr:
> +        ty =3D f'*{"const" if const else "mut"} {ty}'
> +    return ty
> +
>  class Arguments:
>      """Event arguments description."""
>
> @@ -197,6 +316,43 @@ def casted(self):
>          """List of argument names casted to their type."""
>          return ["(%s)%s" % (type_, name) for type_, name in self._args]
>
> +    def rust_decl_extern(self):
> +        """Return a Rust argument list for an extern "C" function"""
> +        return ", ".join((f"_{name}: {c_type_to_rust(type_)}"
> +                          for type_, name in self._args))
> +
> +    def rust_decl(self):
> +        """Return a Rust argument list for a tracepoint function"""
> +        def decl_type(type_):
> +            if type_ =3D=3D "const char *":
> +                return "&std::ffi::CStr"
> +            return c_type_to_rust(type_)
> +
> +        return ", ".join((f"_{name}: {decl_type(type_)}"
> +                          for type_, name in self._args))
> +
> +    def rust_call_extern(self):
> +        """Return a Rust argument list for a call to an extern "C" funct=
ion"""
> +        def rust_cast(name, type_):
> +            if type_ =3D=3D "const char *":
> +                return f"_{name}.as_ptr()"
> +            return "_{name}"

Missing f-prefix for f-string

> +
> +        return ", ".join((rust_cast(name, type_) for type_, name in self=
._args))
> +
> +    def rust_call_varargs(self):
> +        """Return a Rust argument list for a call to a C varargs functio=
n"""
> +        def rust_cast(name, type_):
> +            if type_ =3D=3D "const char *":
> +                return f"_{name}.as_ptr()"
> +
> +            type_ =3D c_type_to_rust(type_)
> +            if type_ in RUST_VARARGS_SMALL_TYPES:
> +                return f"_{name} as std::ffi::c_int"
> +            return f"_{name} /* as {type_} */"
> +
> +        return ", ".join((rust_cast(name, type_) for type_, name in self=
._args))
> +
>
>  class Event(object):
>      """Event description.
> diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs=
.py
> new file mode 100644
> index 00000000000..bc8b2be5971
> --- /dev/null
> +++ b/scripts/tracetool/format/rs.py
> @@ -0,0 +1,76 @@
> +# -*- coding: utf-8 -*-
> +
> +"""
> +trace-DIR.rs
> +"""
> +
> +__author__     =3D "Tanish Desai <tanishdesai37@gmail.com>"
> +__copyright__  =3D "Copyright 2025, Tanish Desai <tanishdesai37@gmail.co=
m>"
> +__license__    =3D "GPL version 2 or (at your option) any later version"
> +
> +__maintainer__ =3D "Stefan Hajnoczi"
> +__email__      =3D "stefanha@redhat.com"
> +
> +
> +from tracetool import out
> +
> +
> +def generate(events, backend, group):
> +    out('// This file is autogenerated by tracetool, do not edit.',
> +        '',
> +        '#[allow(unused_imports)]',
> +        'use std::ffi::c_char;',
> +        '#[allow(unused_imports)]',
> +        'use qemu_api::bindings;',
> +        '',
> +        '#[inline(always)]',
> +        'fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {',
> +        '    unsafe { (trace_events_enabled_count !=3D 0) && (_id !=3D 0=
) }',
> +        '}',
> +        '',
> +        'extern "C" {',
> +        '    static mut trace_events_enabled_count: u32;',
> +        '}',)
> +
> +    out('extern "C" {')
> +
> +    for e in events:
> +        out('    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
> +    out('}')
> +
> +    # static state
> +    for e in events:
> +        if 'disable' in e.properties:
> +            enabled =3D "false"
> +        else:
> +            enabled =3D "true"
> +        if "tcg-exec" in e.properties:
> +            # a single define for the two "sub-events"
> +            out('const _TRACE_%(name)s_ENABLED: bool =3D %(enabled)s;',
> +                name=3De.original.name.upper(),
> +                               enabled=3Denabled)
> +        out('const _TRACE_%s_ENABLED: bool =3D %s;' % (e.name.upper(), e=
nabled))
> +
> +    backend.generate_begin(events, group)
> +
> +    for e in events:
> +        out('',
> +                       '#[inline(always)]',
> +            '#[allow(dead_code)]',
> +            'pub fn %(api)s(%(args)s)',
> +            '{',
> +            api=3De.api(e.QEMU_TRACE),
> +            args=3De.args.rust_decl())
> +
> +        if "disable" not in e.properties:
> +            backend.generate(e, group, check_trace_event_get_state=3DFal=
se)
> +            if backend.check_trace_event_get_state:
> +                event_id =3D 'TRACE_' + e.name.upper()
> +                out('    if trace_event_get_state_dynamic_by_id(unsafe {=
 _%(event_id)s_DSTATE}) {',
> +                    event_id =3D event_id,
> +                    api=3De.api())
> +                backend.generate(e, group, check_trace_event_get_state=
=3DTrue)
> +                out('    }')
> +        out('}')
> +
> +    backend.generate_end(events, group)
> --
> 2.50.1
>
>

