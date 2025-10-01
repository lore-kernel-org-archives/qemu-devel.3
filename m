Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA82CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmb-0005pQ-C5; Wed, 01 Oct 2025 04:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmS-0005kw-RA
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rm6-00066n-LW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpbUCXWumUutQXKcAKRuxkw1Z26bH7EaIZnCKK3LwfU=;
 b=MYKEvwFyC7DUa6MHa4QbJqY1usl4pTky37mhylflltSc5HY/ZlLDyh2aRtpsEwCnLtAHB1
 QfTJeljynxB9ZRqUWKWRCZxXLdB7ViHBEIn7KodvGHnN1XldAUVuT6+i1NCJ1cDg7Bn4zf
 kI+5pw5K9tvibQgQoXo2i3Gb/F/20UI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-BXg5-aVxNZa_yGnXEyEaug-1; Wed, 01 Oct 2025 04:01:19 -0400
X-MC-Unique: BXg5-aVxNZa_yGnXEyEaug-1
X-Mimecast-MFC-AGG-ID: BXg5-aVxNZa_yGnXEyEaug_1759305678
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3f2cfc26edso87239066b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305677; x=1759910477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpbUCXWumUutQXKcAKRuxkw1Z26bH7EaIZnCKK3LwfU=;
 b=hP+KCuSstcVpSbOCMibImhaSLOZ2WFIGLwzX95Z0f9/sLbydG1bNxlTw7og3iO2eVd
 GCN6xD1qQRqI48fT2G+sdAuaG70nyxoAGu0VA54Kam334e3Rv5BarHE8t7bFEH+BwvaE
 vRJuv7UroCEqLdavTlcAjFx3D27NOzAQwqxjtj94KF68d7TjszPjiSrxMyk8eHIERQIt
 znNRiyJEK5hNOpJHTX7PNGTzaXgcVRyIs8Z/6zIY3FvAT0Q715TWLe1PIDM/9gYxUSnq
 Aq1ZgbCErb8Lmm6fsL0RqJ9QNJLOt9RzhZGei4Xg+sF6XbwgaDOCHXmtEp8FRmeXrkHX
 Y4Ww==
X-Gm-Message-State: AOJu0YykUqRSKhGK4tf2Vt1baDlvh3KYtvwDDd9lfowhQ3xZoxeb57J/
 UuJZ18sxbLyL4i1fYOPxoRDlrAJkSqwKvhdext+W1EAo8OJ3OYJdgPmwt982lmP/rrFSEhco5pV
 xW6a7j84qyB7PG75InivMD3VnrT58x+TQKYtPsB/Zxe7PqkzVM7Qy7MdSBvlGYjgPb0x28ct5Ea
 89u6qxjxnykJdIMlsUyeZKjkEY7NwaT8qe3DOSjCPO
X-Gm-Gg: ASbGncvD9RFYCrhCyHejQh72u34j10l268zG3dL+VDlM+eLH/E7jhQnIB1KT8Yi46Nu
 7lSa88f0v/ZpfKkZEf0neDwuFNCfqoJBZMTcBdaXjf5iJt2oOj5dynsCg6RcQX9zvMOkQ2XRPZh
 S3I/fS2YswPcWoD+TnpDsTxfaIeioLZAEJXK+SCFDfYK9s2FUZ7pDWORX2AOlwgPMDpxGhI3Soz
 o55ar4U0I8F5z1St39mBr5XX8AO4qjX8CXI5mZKoEpcmV5xI9XfYtQkMZzyApoRjDAVHzylQxF6
 l+MMC3es0FZ69g2ZK2fwJEESMvSGAYDhhkiepey1u23nifTibgaVXqsYnpTb8ZbIEvZLkE62xOc
 PzY+FMjodHRvSTYx0V7YRQOgsKaHo+hWMXMMf1jAyaPRdXe+OIDI=
X-Received: by 2002:a17:907:6d0b:b0:b3a:b22e:dd35 with SMTP id
 a640c23a62f3a-b46e47a9d81mr319830066b.2.1759305676911; 
 Wed, 01 Oct 2025 01:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfNHYiIo1e4KeQpM+zco2Axk4HTwNCzV82bJEzwhtc530NnzcnXT/uvH8LiASKUJPIsE2l9A==
X-Received: by 2002:a17:907:6d0b:b0:b3a:b22e:dd35 with SMTP id
 a640c23a62f3a-b46e47a9d81mr319820766b.2.1759305676254; 
 Wed, 01 Oct 2025 01:01:16 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3e60de51c5sm629934066b.15.2025.10.01.01.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 10/14] scripts/qapi: generate high-level Rust bindings
Date: Wed,  1 Oct 2025 10:00:47 +0200
Message-ID: <20251001080051.1043944-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Generate high-level native Rust declarations for the QAPI types.

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
 scripts/qapi/backend.py  |  28 +++-
 scripts/qapi/main.py     |   4 +-
 scripts/qapi/rs.py       | 176 +++++++++++++++++++
 scripts/qapi/rs_types.py | 354 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 562 insertions(+), 4 deletions(-)
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_types.py

diff --git a/meson.build b/meson.build
index 0eb4f850582..8236205d4c5 100644
--- a/meson.build
+++ b/meson.build
@@ -3559,12 +3559,14 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
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
index 49ae6ecdd33..9b9c9708f46 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -7,6 +7,7 @@
 from .events import gen_events
 from .features import gen_features
 from .introspect import gen_introspect
+from .rs_types import gen_rs_types
 from .schema import QAPISchema
 from .types import gen_types
 from .visit import gen_visit
@@ -36,7 +37,7 @@ def generate(self,
         """
 
 
-class QAPICBackend(QAPIBackend):
+class QAPICodeBackend(QAPIBackend):
     # pylint: disable=too-few-public-methods
 
     def generate(self,
@@ -63,3 +64,28 @@ def generate(self,
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
         gen_introspect(schema, output_dir, prefix, unmask)
+
+
+
+class QAPIRsBackend(QAPIBackend):
+    # pylint: disable=too-few-public-methods
+
+    def generate(self,
+                 schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str,
+                 unmask: bool,
+                 builtins: bool,
+                 gen_tracing: bool) -> None:
+        """
+        Generate Rust code for the given schema into the target directory.
+
+        :param schema_file: The primary QAPI schema file.
+        :param output_dir: The output directory to store generated code.
+        :param prefix: Optional C-code prefix for symbol names.
+        :param unmask: Expose non-ABI names through introspection?
+        :param builtins: Generate code for built-in types?
+
+        :raise QAPIError: On failures.
+        """
+        gen_rs_types(schema, output_dir, prefix, builtins)
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
index 00000000000..37b9d4ad569
--- /dev/null
+++ b/scripts/qapi/rs.py
@@ -0,0 +1,176 @@
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
+            qapi_ns: str = 'qapi::',
+            optional: bool = False,
+            box: bool = False) -> str:
+    (is_pointer, _, is_list, c_type) = rs_ctype_parse(c_type)
+    to_rs = {
+        'QNull': '()',
+        'QObject': 'QObject',
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
+    ret = to_rs.get(c_type, qapi_ns + c_type)
+    if is_list:
+        ret = 'Vec<%s>' % ret
+    elif is_pointer and c_type not in to_rs and box:
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
index 00000000000..f124106d7f0
--- /dev/null
+++ b/scripts/qapi/rs_types.py
@@ -0,0 +1,354 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust types generator
+"""
+
+from typing import List, Optional, Set
+
+from .common import camel_to_upper, mcgen
+from .rs import (
+    QAPISchemaRsVisitor,
+    rs_name,
+    rs_type,
+    to_camel_case,
+    to_snake_case,
+)
+from .schema import (
+    QAPISchema,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaBuiltinType,
+    QAPISchemaAlternateType,
+    QAPISchemaArrayType,
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
+                           variants: QAPISchemaVariants) -> str:
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
+                    variants: QAPISchemaVariants) -> str:
+    ret = mcgen('''
+
+%(cfg)s
+#[derive(Clone, Debug, Serialize, Deserialize)]
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
+                   exclude: Optional[List[str]] = None) -> List[str]:
+    exclude = exclude or []
+    return [f"{m.ifcond.rsgen()} {to_snake_case(rs_name(m.name))}"
+            for m in members if m.name not in exclude]
+
+
+def has_recursive_type(memb: QAPISchemaType,
+                       name: str,
+                       visited: Set[str]) -> bool:
+    if name == memb.name:
+        return True
+    if memb.name in visited:
+        return False
+    visited.add(memb.name)
+    if isinstance(memb, QAPISchemaObjectType):
+        if memb.base and has_recursive_type(memb.base, name, visited):
+            return True
+        if memb.branches and any(has_recursive_type(m.type, name, visited) for m in memb.branches.variants):
+            return True
+        if any(has_recursive_type(m.type, name, visited) for m in memb.members):
+            return True
+        return any(has_recursive_type(m.type, name, visited) for m in memb.local_members)
+    elif isinstance(memb, QAPISchemaAlternateType):
+        return any(has_recursive_type(m.type, name, visited) for m in memb.alternatives.variants)
+    elif isinstance(memb, QAPISchemaArrayType):
+        return has_recursive_type(memb.element_type, name, visited)
+    else:
+        pass
+    return False
+
+
+def gen_struct_members(members: List[QAPISchemaObjectTypeMember],
+                       name: str) -> str:
+    ret = ''
+    for memb in members:
+        is_recursive = has_recursive_type(memb.type, name, set())
+        typ = rs_type(memb.type.c_type(), '', optional=memb.optional, box=is_recursive)
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
+#[derive(Clone, Debug, Serialize, Deserialize)]
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
+        ret += gen_struct_members(base_members, name)
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Own members:
+''')
+
+    ret += gen_struct_members(members, name)
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
+#[derive(Copy, Clone, Debug, Serialize, Deserialize, PartialEq, Eq, common::TryInto)]
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
+                     variants: QAPISchemaVariants) -> str:
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+
+    ret += mcgen('''
+%(cfg)s
+#[derive(Clone, Debug, Serialize, Deserialize)]
+pub enum %(rs_name)s {
+''',
+                 cfg=ifcond.rsgen(),
+                 rs_name=rs_name(name))
+
+    for var in variants.variants:
+        if var.type.name == 'q_empty':
+            continue
+        is_recursive = has_recursive_type(var.type, name, set())
+        ret += mcgen('''
+        %(cfg)s
+        %(mem_name)s(%(rs_type)s),
+''',
+                     cfg=var.ifcond.rsgen(),
+                     rs_type=rs_type(var.type.c_unboxed_type(), '', box=is_recursive),
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
+#![allow(unexpected_cfgs)]
+#![allow(non_camel_case_types)]
+#![allow(non_upper_case_globals)]
+
+use serde_derive::{Serialize, Deserialize};
+
+use util::qobject::QObject;
+'''))
+
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          branches: Optional[QAPISchemaVariants]) -> None:
+        if name.startswith('q_'):
+            return
+        self._gen.add(gen_rs_object(name, ifcond, base, members, branches))
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
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             alternatives: QAPISchemaVariants) -> None:
+        self._gen.add(gen_rs_alternate(name, ifcond, alternatives))
+
+
+def gen_rs_types(schema: QAPISchema, output_dir: str, prefix: str,
+                 builtins: bool) -> None:
+    # pylint: disable=unused-argument
+    # TODO: builtins?
+    vis = QAPISchemaGenRsTypeVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
-- 
2.51.0


