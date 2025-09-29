Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C3CCA470
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9i-0001Xp-J0; Mon, 29 Sep 2025 11:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8z-0000yZ-Et
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8h-0000Yq-8R
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnujfHEUsT4zeQl55kL0VsIZnIBBEpQNJFLRyfhk2f4=;
 b=Mqsh01YtRLYUZIDUBQXLZXiGgZEnOrqKUkPB1iFhs7aP+6TA06P24nb1MRdVAU7vKQZekA
 kvKZaMkoVlXwk8bXF2Jh1LjZ+X6ln3L7LnStQ2C2w2LmfBGaglmco58hNn/E83rGoSQVN3
 htJ9AFIx+ZU3Zk+Hrqt+F4wBFUOCU1c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-4xO3PIJJN6GB1WkU9JC3oA-1; Mon, 29 Sep 2025 11:50:03 -0400
X-MC-Unique: 4xO3PIJJN6GB1WkU9JC3oA-1
X-Mimecast-MFC-AGG-ID: 4xO3PIJJN6GB1WkU9JC3oA_1759161003
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3cbee9769fso215101566b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161002; x=1759765802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnujfHEUsT4zeQl55kL0VsIZnIBBEpQNJFLRyfhk2f4=;
 b=izAjlzZcri6WWNGliw2CqN6PzUVV22BEvgi9FNJ2ACE2xqLThpHGFOGxqxSU1o1xhb
 k92Wtllk9WmwV8ENFkzTNTQJ0LXI5mFERTwKP8Wbe1jNIbsEW7i0oEsxiKhPtJ3JPESj
 Kg76FwtcnCgqr5Wn3Dap3EVCa8xWKwDOttVhT9CHmogRg3rtX+yYT8NSFK7+Rn5gvpwU
 kTpS0Qmuter5uXI03w7qaXncjb0pUxNAJ2L/l1ZKGtazJ6J6RwtwhpUzHSd+kz8LqSlq
 z4l4+L/h2BRnowGPX5RvlyzCcPX+Uo5ewIz/4iWzMcH7OEcGX4gBxQas26woQ5Wo1282
 4yMw==
X-Gm-Message-State: AOJu0Yz9xG8fbJe7TX4ALHs50DWTk6W5KagNprsRxgrWiZ3jWPlpPx3Z
 w461kkPII8cok+exds5IVEx6dF7GxhUDFzdHGx69PMLUPnhqOXqq5kld6yEbQ5mNoR5UTb2++hu
 oK5tLIYhvBlcT82DVcl/I6hN4UwK+WBHgFMyvq4dw0B6qgPVDWZZaNCK556Gc2ruC/1bXlnyNS1
 oCHIRdLpsdquLA77YBnfTz8SDjD9K3I4SkRj12gDfW
X-Gm-Gg: ASbGncsV6Ww32V2waik+BO7MQBwx1hPDLGI1g6POsfFF0LWUfUgw6ocgWtwS4t8x2p5
 J1XvTveB7YCgnFVWmdq3TBmKNYQTeG5fE+9HiFFDBt35NxUR8r4kcMN9mQhmFUbdGLSTGZhrsvk
 oPE0/J50MmsQrety4qjdld+NQPmz2yyG88gerLP6tFcNFmxBJMQwtQ7c9hLt+BozKM9hC8gyTPc
 +MqE32XvgA3oSZP7r+BAVA6CtO8P90KsZPHz2/U5WtiVJeBNtW2W+D7dJ1bxXOsg0nXuglA6w3V
 PfTLIKKQRxSm5KaIW9Nao2pDzX0vddoHDN6osfagNuIa2HM0QE3vcLFD9L5bcZ78VQXgqJlcFdF
 DjOow5ENXQ5FUPNlOhFJzENk3yKnbGD12oSVCG46avC5OKQ==
X-Received: by 2002:a17:906:fd84:b0:b04:274a:fc87 with SMTP id
 a640c23a62f3a-b34b91a1ef7mr1991548166b.4.1759161001768; 
 Mon, 29 Sep 2025 08:50:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX/ljrXCooabK16vmgxiEJoxdR/vGT54DG2evcJRvblSg0bTEa+d5/eXEwWGhhK/8qQKQvwg==
X-Received: by 2002:a17:906:fd84:b0:b04:274a:fc87 with SMTP id
 a640c23a62f3a-b34b91a1ef7mr1991543966b.4.1759161001261; 
 Mon, 29 Sep 2025 08:50:01 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3b052d4sm7944856a12.48.2025.09.29.08.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 08/16] tracetool: Add Rust format support
Date: Mon, 29 Sep 2025 17:49:30 +0200
Message-ID: <20250929154938.594389-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Tanish Desai <tanishdesai37@gmail.com>

Generating .rs files makes it possible to support tracing in rust.
This support comprises a new format, and common code that converts
the C expressions in trace-events to Rust.  In particular, types
need to be converted, and PRI macros expanded.

As of this commit no backend generates Rust code, but it is already
possible to use tracetool to generate Rust sources; they are not
functional but they compile and contain tracepoint functions.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
[Move Rust argument conversion from Event to Arguments; string
 support. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py  | 155 +++++++++++++++++++++++++++++++++
 scripts/tracetool/format/rs.py |  64 ++++++++++++++
 2 files changed, 219 insertions(+)
 create mode 100644 scripts/tracetool/format/rs.py

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index c4fa0f74e6f..74062d21a7c 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -30,6 +30,49 @@ def error(*lines):
     error_write(*lines)
     sys.exit(1)
 
+FMT_TOKEN = re.compile(r'''(?:
+                       " ( (?: [^"\\] | \\[\\"abfnrt] |            # a string literal
+                               \\x[0-9a-fA-F][0-9a-fA-F]) *? ) "
+                       | ( PRI [duixX] (?:8|16|32|64|PTR|MAX) )    # a PRIxxx macro
+                       | \s+                                       # spaces (ignored)
+                       )''', re.X)
+
+PRI_SIZE_MAP = {
+    '8':  'hh',
+    '16': 'h',
+    '32': '',
+    '64': 'll',
+    'PTR': 't',
+    'MAX': 'j',
+}
+
+def expand_format_string(c_fmt, prefix=""):
+    def pri_macro_to_fmt(pri_macro):
+        assert pri_macro.startswith("PRI")
+        fmt_type = pri_macro[3]  # 'd', 'i', 'u', or 'x'
+        fmt_size = pri_macro[4:]  # '8', '16', '32', '64', 'PTR', 'MAX'
+
+        size = PRI_SIZE_MAP.get(fmt_size, None)
+        if size is None:
+            raise Exception(f"unknown macro {pri_macro}")
+        return size + fmt_type
+
+    result = prefix
+    pos = 0
+    while pos < len(c_fmt):
+        m = FMT_TOKEN.match(c_fmt, pos)
+        if not m:
+            print("No match at position", pos, ":", repr(c_fmt[pos:]), file=sys.stderr)
+            raise Exception("syntax error in trace file")
+        if m[1]:
+            substr = m[1]
+        elif m[2]:
+            substr = pri_macro_to_fmt(m[2])
+        else:
+            substr = ""
+        result += substr
+        pos = m.end()
+    return result
 
 out_lineno = 1
 out_filename = '<none>'
@@ -89,6 +132,49 @@ def out(*lines, **kwargs):
     "ptrdiff_t",
 ]
 
+C_TYPE_KEYWORDS = {"char", "int", "void", "short", "long", "signed", "unsigned"}
+
+C_TO_RUST_TYPE_MAP = {
+    "int": "std::ffi::c_int",
+    "long": "std::ffi::c_long",
+    "long long": "std::ffi::c_longlong",
+    "short": "std::ffi::c_short",
+    "char": "std::ffi::c_char",
+    "bool": "bool",
+    "unsigned": "std::ffi::c_uint",
+    # multiple keywords, keep them sorted
+    "long unsigned": "std::ffi::c_long",
+    "long long unsigned": "std::ffi::c_ulonglong",
+    "short unsigned": "std::ffi::c_ushort",
+    "char unsigned": "u8",
+    "int8_t": "i8",
+    "uint8_t": "u8",
+    "int16_t": "i16",
+    "uint16_t": "u16",
+    "int32_t": "i32",
+    "uint32_t": "u32",
+    "int64_t": "i64",
+    "uint64_t": "u64",
+    "void": "()",
+    "size_t": "usize",
+    "ssize_t": "isize",
+    "uintptr_t": "usize",
+    "ptrdiff_t": "isize",
+}
+
+# Rust requires manual casting of <32-bit types when passing them to
+# variable-argument functions.
+RUST_VARARGS_SMALL_TYPES = {
+    "std::ffi::c_short",
+    "std::ffi::c_ushort",
+    "std::ffi::c_char",
+    "i8",
+    "u8",
+    "i16",
+    "u16",
+    "bool",
+}
+
 def validate_type(name):
     bits = name.split(" ")
     for bit in bits:
@@ -104,6 +190,38 @@ def validate_type(name):
                              "other complex pointer types should be "
                              "declared as 'void *'" % name)
 
+def c_type_to_rust(name):
+    ptr = False
+    const = False
+    name = name.rstrip()
+    if name[-1] == '*':
+        name = name[:-1].rstrip()
+        ptr = True
+        if name[-1] == '*':
+            # pointers to pointers are the same as void*
+            name = "void"
+
+    bits = name.split()
+    if "const" in bits:
+        const = True
+        bits.remove("const")
+    if bits[0] in C_TYPE_KEYWORDS:
+        if "signed" in bits:
+            bits.remove("signed")
+        if len(bits) > 1 and "int" in bits:
+            bits.remove("int")
+        bits.sort()
+        name = ' '.join(bits)
+    else:
+        if len(bits) > 1:
+            raise ValueError("Invalid type '%s'." % name)
+        name = bits[0]
+
+    ty = C_TO_RUST_TYPE_MAP[name.strip()]
+    if ptr:
+        ty = f'*{"const" if const else "mut"} {ty}'
+    return ty
+
 class Arguments:
     """Event arguments description."""
 
@@ -192,6 +310,43 @@ def casted(self):
         """List of argument names casted to their type."""
         return ["(%s)%s" % (type_, name) for type_, name in self._args]
 
+    def rust_decl_extern(self):
+        """Return a Rust argument list for an extern "C" function"""
+        return ", ".join((f"_{name}: {c_type_to_rust(type_)}"
+                          for type_, name in self._args))
+
+    def rust_decl(self):
+        """Return a Rust argument list for a tracepoint function"""
+        def decl_type(type_):
+            if type_ == "const char *":
+                return "&std::ffi::CStr"
+            return c_type_to_rust(type_)
+
+        return ", ".join((f"_{name}: {decl_type(type_)}"
+                          for type_, name in self._args))
+
+    def rust_call_extern(self):
+        """Return a Rust argument list for a call to an extern "C" function"""
+        def rust_cast(name, type_):
+            if type_ == "const char *":
+                return f"_{name}.as_ptr()"
+            return f"_{name}"
+
+        return ", ".join((rust_cast(name, type_) for type_, name in self._args))
+
+    def rust_call_varargs(self):
+        """Return a Rust argument list for a call to a C varargs function"""
+        def rust_cast(name, type_):
+            if type_ == "const char *":
+                return f"_{name}.as_ptr()"
+
+            type_ = c_type_to_rust(type_)
+            if type_ in RUST_VARARGS_SMALL_TYPES:
+                return f"_{name} as std::ffi::c_int"
+            return f"_{name} /* as {type_} */"
+
+        return ", ".join((rust_cast(name, type_) for type_, name in self._args))
+
 
 class Event(object):
     """Event description.
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
new file mode 100644
index 00000000000..32ac4e59770
--- /dev/null
+++ b/scripts/tracetool/format/rs.py
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""
+trace-DIR.rs
+"""
+
+__author__     = "Tanish Desai <tanishdesai37@gmail.com>"
+__copyright__  = "Copyright 2025, Tanish Desai <tanishdesai37@gmail.com>"
+__license__    = "GPL version 2 or (at your option) any later version"
+
+__maintainer__ = "Stefan Hajnoczi"
+__email__      = "stefanha@redhat.com"
+
+
+from tracetool import out
+
+
+def generate(events, backend, group):
+    out('// SPDX-License-Identifier: GPL-2.0-or-later',
+        '// This file is @generated by tracetool, do not edit.',
+        '',
+        '#[allow(unused_imports)]',
+        'use std::ffi::c_char;',
+        '#[allow(unused_imports)]',
+        'use util::bindings;',
+        '',
+        '#[inline(always)]',
+        'fn trace_event_state_is_enabled(dstate: u16) -> bool {',
+        '    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0',
+        '}',
+        '',
+        'extern "C" {',
+        '    static mut trace_events_enabled_count: u32;',
+        '}',)
+
+    out('extern "C" {')
+
+    for e in events:
+        out('    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
+    out('}')
+
+    backend.generate_begin(events, group)
+
+    for e in events:
+        out('',
+            '#[inline(always)]',
+            '#[allow(dead_code)]',
+            'pub fn %(api)s(%(args)s)',
+            '{',
+            api=e.api(e.QEMU_TRACE),
+            args=e.args.rust_decl())
+
+        if "disable" not in e.properties:
+            backend.generate(e, group, check_trace_event_get_state=False)
+            if backend.check_trace_event_get_state:
+                event_id = 'TRACE_' + e.name.upper()
+                out('    if trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) {',
+                    event_id = event_id,
+                    api=e.api())
+                backend.generate(e, group, check_trace_event_get_state=True)
+                out('    }')
+        out('}')
+
+    backend.generate_end(events, group)
-- 
2.51.0


