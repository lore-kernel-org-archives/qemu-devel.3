Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5309DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18cT-0004p3-1S; Tue, 23 Sep 2025 15:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18cR-0004oN-AR
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18cP-00076C-33
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758655443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hQujldYOkJSiLuRw/jzm97StSNFnDtlEVoHUwDixRQ0=;
 b=AU/CFoCIWX9dv10EkcDe6XqpeIqstAEeBf35YMrbLJidXkOD9qictkdee95AAy5RWBeKXC
 Usa9/BGIEXbRaMYtJKTz4o1YuM6RmvW4qoaxyn1GPFuM0VnX0q+7yFnp/OqxbCGPj7ys/6
 RNqDKZjmlL0kEpCFOrOC57B3PihXfUU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-oQnkSxV_OFG2E7cri0VuFg-1; Tue,
 23 Sep 2025 15:23:58 -0400
X-MC-Unique: oQnkSxV_OFG2E7cri0VuFg-1
X-Mimecast-MFC-AGG-ID: oQnkSxV_OFG2E7cri0VuFg_1758655437
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B395E19560A7; Tue, 23 Sep 2025 19:23:56 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CBD4180035E; Tue, 23 Sep 2025 19:23:55 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:23:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
Message-ID: <20250923192354.GL509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7sarsVfnZ4KbpEW7"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-9-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--7sarsVfnZ4KbpEW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:28PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
>=20
> Generating .rs files makes it possible to support tracing in rust.
> This support comprises a new format, and common code that converts
> the C expressions in trace-events to Rust.  In particular, types
> need to be converted, and PRI macros expanded.
>=20
> As of this commit no backend generates Rust code, but it is already
> possible to use tracetool to generate Rust sources; they are not
> functional but they compile and contain tracepoint functions.
>=20
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> [Move Rust argument conversion from Event to Arguments; string
>  support. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py  | 155 +++++++++++++++++++++++++++++++++
>  scripts/tracetool/format/rs.py |  71 +++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 scripts/tracetool/format/rs.py
>=20
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index a58d7938658..ea3e83f5adf 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -31,6 +31,49 @@ def error(*lines):
>      error_write(*lines)
>      sys.exit(1)
> =20
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
> +        fmt_size =3D pri_macro[4:]  # '8', '16', '32', '64', 'PTR', 'MAX'
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
> =20
>  out_lineno =3D 1
>  out_filename =3D '<none>'
> @@ -90,6 +133,49 @@ def out(*lines, **kwargs):
>      "ptrdiff_t",
>  ]
> =20
> +C_TYPE_KEYWORDS =3D {"char", "int", "void", "short", "long", "signed", "=
unsigned"}
> +
> +C_TO_RUST_TYPE_MAP =3D {
> +    "int": "std::ffi::c_int",
> +    "long": "std::ffi::c_long",
> +    "long long": "std::ffi::c_longlong",
> +    "short": "std::ffi::c_short",
> +    "char": "std::ffi::c_char",
> +    "bool": "bool",
> +    "unsigned": "std::ffi::c_uint",
> +    # multiple keywords, keep them sorted
> +    "long unsigned": "std::ffi::c_long",
> +    "long long unsigned": "std::ffi::c_ulonglong",
> +    "short unsigned": "std::ffi::c_ushort",
> +    "char unsigned": "u8",
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
> @@ -105,6 +191,38 @@ def validate_type(name):
>                               "other complex pointer types should be "
>                               "declared as 'void *'" % name)
> =20
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
> +    bits =3D name.split()
> +    if "const" in bits:
> +        const =3D True
> +        bits.remove("const")
> +    if bits[0] in C_TYPE_KEYWORDS:
> +        if "signed" in bits:
> +            bits.remove("signed")
> +        if len(bits) > 1 and "int" in bits:
> +            bits.remove("int")
> +        bits.sort()
> +        name =3D ' '.join(bits)
> +    else:
> +        if len(bits) > 1:
> +            raise ValueError("Invalid type '%s'." % name)
> +        name =3D bits[0]
> +
> +    ty =3D C_TO_RUST_TYPE_MAP[name.strip()]
> +    if ptr:
> +        ty =3D f'*{"const" if const else "mut"} {ty}'
> +    return ty
> +
>  class Arguments:
>      """Event arguments description."""
> =20
> @@ -193,6 +311,43 @@ def casted(self):
>          """List of argument names casted to their type."""
>          return ["(%s)%s" % (type_, name) for type_, name in self._args]
> =20
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
> +            return f"_{name}"
> +
> +        return ", ".join((rust_cast(name, type_) for type_, name in self=
=2E_args))
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
=2E_args))
> +
> =20
>  class Event(object):
>      """Event description.
> diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs=
=2Epy
> new file mode 100644
> index 00000000000..c4ab0e59d85
> --- /dev/null
> +++ b/scripts/tracetool/format/rs.py
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
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
> +    out('// SPDX-License-Identifier: GPL-2.0-or-later',
> +        '// This file is @generated by tracetool, do not edit.',
> +        '',
> +        '#[allow(unused_imports)]',
> +        'use std::ffi::c_char;',
> +        '#[allow(unused_imports)]',
> +        'use util::bindings;',
> +        '',
> +        '#[inline(always)]',
> +        'fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {',
> +        '    unsafe { (trace_events_enabled_count !=3D 0) && (_id !=3D 0=
) }',
> +        '}',

This was translated to Rust from:

  /* it's on fast path, avoid consistency checks (asserts) */
  #define trace_event_get_state_dynamic_by_id(id) \
      (unlikely(trace_events_enabled_count) && _ ## id ## _DSTATE)

The _id !=3D 0 expression is incorrect. The purpose was to check whether
the trace event is currently enabled (i.e. dynamically at runtime).

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

What is the purpose of this loop? The variable enabled is unused so I
think it can be deleted.

> +
> +    backend.generate_begin(events, group)
> +
> +    for e in events:
> +        out('',
> +			'#[inline(always)]',

Tabs snuck in here. This should be indented with spaces.

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
> --=20
> 2.51.0
>=20
>=20

--7sarsVfnZ4KbpEW7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS88oACgkQnKSrs4Gr
c8iFDwgAr4LYaHPGQYWSRn6SmO2wJq1Y9OB30YRyGEWOtHF0IEgiDmOMdeII2dUO
i2kj0N4NEvXNNy4qbLH8rViUOezEMkMIS56uKfLK4i+Tn5ana1DUcLcWgSV7iC6n
g1WSRu+pwWt4bUcFqy3O6xCnm1/P6EZRgeHavTj5qzGnvp2B7RWHKn5JgQbn9cam
hDb3ByLRem+bS5ya+lV01x5F5B3GKpvVPQjZpSYP33yZn3Cg6axatIpaLHADBv/0
gRLxu9KyjwnGtCLtcEUixpYFIXCDBxaHlnLZL32q1Mo5+QFl6XgAgxHUI8V5k/j6
A0k0xKllWfcL+MPhIIM9UGkKDxJWcA==
=JTMZ
-----END PGP SIGNATURE-----

--7sarsVfnZ4KbpEW7--


