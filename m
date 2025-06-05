Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CE8C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7Zb-00041Z-2X; Thu, 05 Jun 2025 06:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZW-00040N-Uk
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZU-0000Vf-3p
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYMOReItctF9KrcV1t1g/12s8f5Ezu9FYcg+CXT4RJg=;
 b=YrEPwFaOaQnJV8igzAw6Wz5WxFuzAzPK5ur6bGbmCfB1ktWhUlCVcXMCeJUbKjmd+kqIVv
 3BuF7/AhNMopzs5ZhyWOzrqOCygDAje5hSqbAfuGrGJWSIttDp9s44G+NZtgqweCaxkw8u
 Mpjx++IF6Cmfh3NYH4n5MEDn7JvWERY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-Z9_RqljdN2SYOdDbzJ9Zcg-1; Thu, 05 Jun 2025 06:11:38 -0400
X-MC-Unique: Z9_RqljdN2SYOdDbzJ9Zcg-1
X-Mimecast-MFC-AGG-ID: Z9_RqljdN2SYOdDbzJ9Zcg_1749118297
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-445135eb689so4172975e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118295; x=1749723095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYMOReItctF9KrcV1t1g/12s8f5Ezu9FYcg+CXT4RJg=;
 b=nqZ+TLJoy2TNSePP2wR2+J5Hzp1QOzejhMs0qqzL2mo5NAhiC25n9DF7Iav7xzUtde
 b6bzWziwfhQIWAdNon9kD94aD+TAqxIQ6WJRkbE7JfustsTWJhR1HVi+y9CGzieDSWPG
 ZMeTvUY7rxrEnORGvJmmE3ostYN7ZRiwa7VUbJ9i9rMO/KGDz3lr34N7BQpVuMyWuCPL
 NI6v4+Xiv3j91hb+yhsQHIomkmVMcLVHhOqEPNhlQxxe0+EHWyB+/Rv9Sc5Tv9t/+IZK
 bNWthxd46qvoeOm96FyDdzWWH5WypMEtG2SLMqz7XnpifV5kRhELB+hOHMjIbtjgWmKY
 Km+Q==
X-Gm-Message-State: AOJu0YyNirlDBqRLFbQm4FbnHCZnDVJDf59csE8ogAHBHf8IXoq6d5jD
 hzaGc6pmnTTjOYTb6MfF5APyWpAb+OyWrDNq+0RoAs5ey2tKQqneujvE6W8cnk1HoKbvhQa2olE
 PvDZ3T/Iw1rHhZnq32DKI+4rTiR2eqJOaiKqQzEMi1so9sUUUt7P6DstjkRZNGVu9qqS9BUZcDU
 E+j+qX7mlP2Bq1Re39HkNZ6WdaSgcUHYrmrlKtUIfW
X-Gm-Gg: ASbGncshyHqrwGlzVcyxu+7KaCdpShtpcoHQMNSQBuEyi2NU+ihPLd8xHEQg31cHS7Y
 Uk+ze3qJ7yXl8z2T0qy48b7Y0h14yMl8jGnfArsddGdNBa6Lwcr1rEqcLdm0Cnq9iYuHBcdC6dz
 4FGx+Fubmf1MUV0uRtY+Zf0C/yUFTBpKqbT7CKU+ippgqFmfYE9Vf8uvGTKdb0lhw9jJZkSu+wG
 B+0NZ8EePtctn8kikRGuScQGVfIzfxZT0xWnUxv/KWykn0PB44YZdGkgmi/gYLh/7Gugoaiwo2D
 +1HtCBRXxLYw+IJIByrtlnrP
X-Received: by 2002:a05:600c:1ca4:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-451fe3d0e8cmr3057095e9.10.1749118295190; 
 Thu, 05 Jun 2025 03:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj63TSijm1yeGbo2RY9SNv2p+L/XtZB+GX2QMeEGaBYZ//EiKO2a85O0ohboQe5ydz2/funA==
X-Received: by 2002:a05:600c:1ca4:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-451fe3d0e8cmr3056715e9.10.1749118294640; 
 Thu, 05 Jun 2025 03:11:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f99243e6sm19177735e9.35.2025.06.05.03.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:11:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-rust@nongnu.org, armbru@redhat.com,
 mkletzan@redhat.com
Subject: [PATCH 3/3] scripts/qapi: generate high-level Rust bindings
Date: Thu,  5 Jun 2025 12:11:24 +0200
Message-ID: <20250605101124.367270-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101124.367270-1-pbonzini@redhat.com>
References: <20250605101124.367270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Generate high-level idiomatic Rust code for the QAPI types, with to/from
translations for the C FFI.

- char* is mapped to String, scalars to there corresponding Rust types

- enums are simply aliased from FFI

- has_foo/foo members are mapped to Option<T>

- lists are represented as Vec<T>

- structures have Rust versions, with To/From FFI conversions

- alternate are represented as Rust enum

- unions are represented in a similar way as in C: a struct S with a "u"
  member (since S may have extra 'base' fields). However, the discriminant
  isn't a member of S, since Rust enum already include it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build              |   4 +-
 scripts/qapi/backend.py  |   4 +-
 scripts/qapi/main.py     |   4 +-
 scripts/qapi/rs.py       | 183 ++++++++++++++++++++++
 scripts/qapi/rs_types.py | 320 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 511 insertions(+), 4 deletions(-)
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_types.py

diff --git a/meson.build b/meson.build
index 967a10e80b8..cdfbc7241fb 100644
--- a/meson.build
+++ b/meson.build
@@ -3531,12 +3531,14 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/introspect.py',
                      meson.current_source_dir() / 'scripts/qapi/main.py',
                      meson.current_source_dir() / 'scripts/qapi/parser.py',
+                     meson.current_source_dir() / 'scripts/qapi/rs_types.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
                      meson.current_source_dir() / 'scripts/qapi/features.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
-                     meson.current_source_dir() / 'scripts/qapi-gen.py'
+                     meson.current_source_dir() / 'scripts/qapi-gen.py',
+                     meson.current_source_dir() / 'scripts/qapi/rs.py',
 ]
 
 tracetool = [
diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 14e60aa67af..2e76370c72d 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -9,6 +9,7 @@
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .types import gen_types
+from .rs_types import gen_rs_types
 from .visit import gen_visit
 
 
@@ -35,7 +36,7 @@ def generate(self,
         """
 
 
-class QAPICBackend(QAPIBackend):
+class QAPICodeBackend(QAPIBackend):
 
     def generate(self,
                  schema: QAPISchema,
@@ -55,6 +56,7 @@ def generate(self,
 
         :raise QAPIError: On failures.
         """
+        gen_rs_types(schema, output_dir, prefix, builtins)
         gen_types(schema, output_dir, prefix, builtins)
         gen_features(schema, output_dir, prefix)
         gen_visit(schema, output_dir, prefix, builtins)
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 0e2a6ae3f07..4ad75e213f5 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -12,7 +12,7 @@
 import sys
 from typing import Optional
 
-from .backend import QAPIBackend, QAPICBackend
+from .backend import QAPIBackend, QAPICodeBackend
 from .common import must_match
 from .error import QAPIError
 from .schema import QAPISchema
@@ -27,7 +27,7 @@ def invalid_prefix_char(prefix: str) -> Optional[str]:
 
 def create_backend(path: str) -> QAPIBackend:
     if path is None:
-        return QAPICBackend()
+        return QAPICodeBackend()
 
     module_path, dot, class_name = path.rpartition('.')
     if not dot:
diff --git a/scripts/qapi/rs.py b/scripts/qapi/rs.py
new file mode 100644
index 00000000000..c1e76e074fb
--- /dev/null
+++ b/scripts/qapi/rs.py
@@ -0,0 +1,183 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust generator
+"""
+
+import os
+import re
+import subprocess
+from typing import NamedTuple, Optional
+
+from .common import POINTER_SUFFIX
+from .gen import QAPIGen
+from .schema import QAPISchemaModule, QAPISchemaVisitor
+
+
+# see to_snake_case() below
+snake_case = re.compile(r'((?<=[a-z0-9])[A-Z]|(?!^)[A-Z](?=[a-z]))')
+
+
+rs_name_trans = str.maketrans('.-', '__')
+
+
+# Map @name to a valid Rust identifier.
+# If @protect, avoid returning certain ticklish identifiers (like
+# keywords) by prepending raw identifier prefix 'r#'.
+def rs_name(name: str, protect: bool = True) -> str:
+    name = name.translate(rs_name_trans)
+    if name[0].isnumeric():
+        name = '_' + name
+    if not protect:
+        return name
+    # based from the list:
+    # https://doc.rust-lang.org/reference/keywords.html
+    if name in ('Self', 'abstract', 'as', 'async',
+                'await', 'become', 'box', 'break',
+                'const', 'continue', 'crate', 'do',
+                'dyn', 'else', 'enum', 'extern',
+                'false', 'final', 'fn', 'for',
+                'if', 'impl', 'in', 'let',
+                'loop', 'macro', 'match', 'mod',
+                'move', 'mut', 'override', 'priv',
+                'pub', 'ref', 'return', 'self',
+                'static', 'struct', 'super', 'trait',
+                'true', 'try', 'type', 'typeof',
+                'union', 'unsafe', 'unsized', 'use',
+                'virtual', 'where', 'while', 'yield'):
+        name = 'r#' + name
+    # avoid some clashes with the standard library
+    if name in ('String',):
+        name = 'Qapi' + name
+
+    return name
+
+
+def rs_type(c_type: str,
+            qapi_ns: Optional[str] = 'qapi::',
+            optional: Optional[bool] = False,
+            box: bool = False) -> str:
+    (is_pointer, _, is_list, c_type) = rs_ctype_parse(c_type)
+    # accepts QAPI types ('any', 'str', ...) as we translate
+    # qapiList to Rust FFI types here.
+    to_rs = {
+        'any': 'QObject',
+        'bool': 'bool',
+        'char': 'i8',
+        'double': 'f64',
+        'int': 'i64',
+        'int16': 'i16',
+        'int16_t': 'i16',
+        'int32': 'i32',
+        'int32_t': 'i32',
+        'int64': 'i64',
+        'int64_t': 'i64',
+        'int8': 'i8',
+        'int8_t': 'i8',
+        'null': 'QNull',
+        'number': 'f64',
+        'size': 'u64',
+        'str': 'String',
+        'uint16': 'u16',
+        'uint16_t': 'u16',
+        'uint32': 'u32',
+        'uint32_t': 'u32',
+        'uint64': 'u64',
+        'uint64_t': 'u64',
+        'uint8': 'u8',
+        'uint8_t': 'u8',
+        'String': 'QapiString',
+    }
+    if is_pointer:
+        to_rs.update({
+            'char': 'String',
+        })
+
+    if is_list:
+        c_type = c_type[:-4]
+
+    to_rs = to_rs.get(c_type)
+    if to_rs:
+        ret = to_rs
+    else:
+        ret = qapi_ns + c_type
+
+    if is_list:
+        ret = 'Vec<%s>' % ret
+    elif is_pointer and not to_rs and box:
+        ret = 'Box<%s>' % ret
+    if optional:
+        ret = 'Option<%s>' % ret
+    return ret
+
+
+class CType(NamedTuple):
+    is_pointer: bool
+    is_const: bool
+    is_list: bool
+    c_type: str
+
+
+def rs_ctype_parse(c_type: str) -> CType:
+    is_pointer = False
+    if c_type.endswith(POINTER_SUFFIX):
+        is_pointer = True
+        c_type = c_type[:-len(POINTER_SUFFIX)]
+    is_list = c_type.endswith('List')
+    is_const = False
+    if c_type.startswith('const '):
+        is_const = True
+        c_type = c_type[6:]
+
+    c_type = rs_name(c_type)
+    return CType(is_pointer, is_const, is_list, c_type)
+
+
+def to_camel_case(value: str) -> str:
+    # special case for last enum value
+    if value == '_MAX':
+        return value
+    raw_id = False
+    if value.startswith('r#'):
+        raw_id = True
+        value = value[2:]
+    value = ''.join('_' + word if word[0].isdigit()
+                    else word[:1].upper() + word[1:]
+                    for word in filter(None, re.split("[-_]+", value)))
+    if raw_id:
+        return 'r#' + value
+    return value
+
+
+def to_snake_case(value: str) -> str:
+    return snake_case.sub(r'_\1', value).lower()
+
+
+class QAPIGenRs(QAPIGen):
+    pass
+
+
+class QAPISchemaRsVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix: str, what: str):
+        super().__init__()
+        self._prefix = prefix
+        self._what = what
+        self._gen = QAPIGenRs(self._prefix + self._what + '.rs')
+        self._main_module: Optional[str] = None
+
+    def visit_module(self, name: Optional[str]) -> None:
+        if name is None:
+            return
+        if QAPISchemaModule.is_user_module(name):
+            if self._main_module is None:
+                self._main_module = name
+
+    def write(self, output_dir: str) -> None:
+        self._gen.write(output_dir)
+
+        pathname = os.path.join(output_dir, self._gen.fname)
+        try:
+            subprocess.check_call(['rustfmt', pathname])
+        except FileNotFoundError:
+            pass
diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
new file mode 100644
index 00000000000..a182b33917a
--- /dev/null
+++ b/scripts/qapi/rs_types.py
@@ -0,0 +1,320 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust types generator
+"""
+
+from typing import List, Optional
+
+from .common import POINTER_SUFFIX, mcgen
+from .rs import (
+    QAPISchemaRsVisitor,
+    rs_ctype_parse,
+    rs_name,
+    rs_type,
+    to_camel_case,
+    to_snake_case,
+)
+from .schema import (
+    QAPISchema,
+    QAPISchemaEnumMember,
+    QAPISchemaEnumType,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+)
+from .source import QAPISourceInfo
+
+
+objects_seen = set()
+
+
+def gen_rs_variants_to_tag(name: str,
+                           ifcond: QAPISchemaIfCond,
+                           variants: Optional[QAPISchemaVariants]) -> str:
+    ret = mcgen('''
+
+%(cfg)s
+impl From<&%(rs_name)sVariant> for %(tag)s {
+    fn from(e: &%(rs_name)sVariant) -> Self {
+        match e {
+    ''',
+                cfg=ifcond.rsgen(),
+                rs_name=rs_name(name),
+                tag=rs_type(variants.tag_member.type.c_type(), ''))
+
+    for var in variants.variants:
+        type_name = var.type.name
+        var_name = to_camel_case(rs_name(var.name))
+        patt = '(_)'
+        if type_name == 'q_empty':
+            patt = ''
+        ret += mcgen('''
+    %(cfg)s
+    %(rs_name)sVariant::%(var_name)s%(patt)s => Self::%(var_name)s,
+''',
+                     cfg=var.ifcond.rsgen(),
+                     rs_name=rs_name(name),
+                     var_name=var_name,
+                     patt=patt)
+
+    ret += mcgen('''
+        }
+    }
+}
+''')
+    return ret
+
+
+def gen_rs_variants(name: str,
+                    ifcond: QAPISchemaIfCond,
+                    variants: Optional[QAPISchemaVariants]) -> str:
+    ret = mcgen('''
+
+%(cfg)s
+#[derive(Clone,Debug)]
+pub enum %(rs_name)sVariant {
+''',
+                cfg=ifcond.rsgen(),
+                rs_name=rs_name(name))
+
+    for var in variants.variants:
+        type_name = var.type.name
+        var_name = to_camel_case(rs_name(var.name, False))
+        if type_name == 'q_empty':
+            ret += mcgen('''
+    %(cfg)s
+    %(var_name)s,
+''',
+                         cfg=var.ifcond.rsgen(),
+                         var_name=var_name)
+        else:
+            c_type = var.type.c_unboxed_type()
+            if c_type.endswith('_wrapper'):
+                c_type = c_type[6:-8]  # remove q_obj*-wrapper
+            ret += mcgen('''
+    %(cfg)s
+    %(var_name)s(%(rs_type)s),
+''',
+                         cfg=var.ifcond.rsgen(),
+                         var_name=var_name,
+                         rs_type=rs_type(c_type, ''))
+
+    ret += mcgen('''
+}
+''')
+
+    ret += gen_rs_variants_to_tag(name, ifcond, variants)
+
+    return ret
+
+
+def gen_rs_members(members: List[QAPISchemaObjectTypeMember],
+                   exclude: List[str] = None) -> str:
+    exclude = exclude or []
+    return [f"{m.ifcond.rsgen()} {to_snake_case(rs_name(m.name))}"
+            for m in members if m.name not in exclude]
+
+
+def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
+    ret = ''
+    for memb in members:
+        typ = rs_type(memb.type.c_type(), '', optional=memb.optional, box=True)
+        ret += mcgen('''
+    %(cfg)s
+    pub %(rs_name)s: %(rs_type)s,
+''',
+                     cfg=memb.ifcond.rsgen(),
+                     rs_type=typ,
+                     rs_name=to_snake_case(rs_name(memb.name)))
+    return ret
+
+
+def gen_rs_object(name: str,
+                  ifcond: QAPISchemaIfCond,
+                  base: Optional[QAPISchemaObjectType],
+                  members: List[QAPISchemaObjectTypeMember],
+                  variants: Optional[QAPISchemaVariants]) -> str:
+    if name in objects_seen:
+        return ''
+
+    if variants:
+        members = [m for m in members
+                   if m.name != variants.tag_member.name]
+
+    ret = ''
+    objects_seen.add(name)
+
+    if variants:
+        ret += gen_rs_variants(name, ifcond, variants)
+
+    ret += mcgen('''
+
+%(cfg)s
+#[derive(Clone, Debug)]
+pub struct %(rs_name)s {
+''',
+                 cfg=ifcond.rsgen(),
+                 rs_name=rs_name(name))
+
+    if base:
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Members inherited:
+''',
+                         c_name=base.c_name())
+        base_members = base.members
+        if variants:
+            base_members = [m for m in base.members
+                            if m.name != variants.tag_member.name]
+        ret += gen_struct_members(base_members)
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Own members:
+''')
+
+    ret += gen_struct_members(members)
+
+    if variants:
+        ret += mcgen('''
+    pub u: %(rs_type)sVariant,
+''', rs_type=rs_name(name))
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+def gen_rs_enum(name: str,
+                ifcond: QAPISchemaIfCond,
+                members: List[QAPISchemaEnumMember]) -> str:
+    # append automatically generated _max value
+    enum_members = members + [QAPISchemaEnumMember('_MAX', None)]
+
+    ret = mcgen('''
+
+%(cfg)s
+#[repr(u32)]
+#[derive(Copy, Clone, Debug, PartialEq, Eq, qemu_api_macros::TryInto)]
+pub enum %(rs_name)s {
+''',
+                cfg=ifcond.rsgen(),
+                rs_name=rs_name(name))
+
+    for member in enum_members:
+        ret += mcgen('''
+    %(cfg)s
+    %(c_enum)s,
+''',
+                     cfg=member.ifcond.rsgen(),
+                     c_enum=to_camel_case(rs_name(member.name)))
+    # picked the first, since that's what malloc0 does
+    # but arguably could use _MAX instead, or a qapi annotation
+    default = to_camel_case(rs_name(enum_members[0].name))
+    ret += mcgen('''
+}
+
+%(cfg)s
+impl Default for %(rs_name)s {
+    #[inline]
+    fn default() -> %(rs_name)s {
+        Self::%(default)s
+    }
+}
+''',
+                 cfg=ifcond.rsgen(),
+                 rs_name=rs_name(name),
+                 default=default)
+    return ret
+
+
+def gen_rs_alternate(name: str,
+                     ifcond: QAPISchemaIfCond,
+                     variants: Optional[QAPISchemaVariants]) -> str:
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+
+    ret += mcgen('''
+%(cfg)s
+#[derive(Clone, Debug)]
+pub enum %(rs_name)s {
+''',
+                 cfg=ifcond.rsgen(),
+                 rs_name=rs_name(name))
+
+    for var in variants.variants:
+        if var.type.name == 'q_empty':
+            continue
+        ret += mcgen('''
+        %(cfg)s
+        %(mem_name)s(%(rs_type)s),
+''',
+                     cfg=var.ifcond.rsgen(),
+                     rs_type=rs_type(var.type.c_unboxed_type(), ''),
+                     mem_name=to_camel_case(rs_name(var.name)))
+
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+class QAPISchemaGenRsTypeVisitor(QAPISchemaRsVisitor):
+
+    def __init__(self, prefix: str) -> None:
+        super().__init__(prefix, 'qapi-types')
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        # don't visit the empty type
+        objects_seen.add(schema.the_empty_object_type.name)
+        self._gen.preamble_add(
+            mcgen('''
+// generated by qapi-gen, DO NOT EDIT
+
+#![allow(non_camel_case_types)]
+
+use qemu_api::bindings::{QNull, QObject};
+
+'''))
+
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          variants: Optional[QAPISchemaVariants]) -> None:
+        if name.startswith('q_'):
+            return
+        self._gen.add(gen_rs_object(name, ifcond, base, members, variants))
+
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
+        self._gen.add(gen_rs_enum(name, ifcond, members))
+
+    def visit_alternate_type(self,
+                             name: str,
+                             info: QAPISourceInfo,
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             variants: QAPISchemaVariants) -> None:
+        self._gen.add(gen_rs_alternate(name, ifcond, variants))
+
+
+def gen_rs_types(schema: QAPISchema, output_dir: str, prefix: str, builtins: bool) -> None:
+    # TODO: builtins?
+    vis = QAPISchemaGenRsTypeVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
-- 
2.49.0


