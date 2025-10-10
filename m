Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E24CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EmW-0000fS-H8; Fri, 10 Oct 2025 11:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7EmI-0000a0-UX
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Elf-0004BP-An
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7ouAlusqvuJYEEC4ofBOBun0PcWoe56XJ+M6Wb3AdY=;
 b=Gy+fpuvFGYEcEXx3Yuth3sdOwsE16VVcIaxIH5QHJ/v1hT4EvCy9vUdqnGNvyR1PDfTulz
 sUxR8cxq4M/DWQ/iR+bKmlVOoIXDCU1qUlFlWn2wVpeHgpkwTXxRKiD2i+Iam2dE3k6AWP
 y+rN61XjRYNnK8iWh4Jt4WLNmkYZiSY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-bQIlov37PIuB7Clp2LCfDQ-1; Fri, 10 Oct 2025 11:10:46 -0400
X-MC-Unique: bQIlov37PIuB7Clp2LCfDQ-1
X-Mimecast-MFC-AGG-ID: bQIlov37PIuB7Clp2LCfDQ_1760109045
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b2d1072a9c4so194909366b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109044; x=1760713844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7ouAlusqvuJYEEC4ofBOBun0PcWoe56XJ+M6Wb3AdY=;
 b=wNZlGPwigEZj3HkVU6zYgvgf4/A5BkBvDj2MQ4l4sx7KXVkoT8fASaY4Ov01ZapcFf
 GnfJQvL6kLkMp+Ru2PPDgSjcQYRvW8r+tEBGvhVAQ/FDtciCC5V9WQzejBpM/h+K+ncw
 71PzHzeRVIuE5ali1IxIu3jS8IOOouSWwI9WRpwxPwMwc0xqf4JSNtramP0hH1g+ucYU
 iWHT1zmfA1gZT8dbn2BSkhv4omUC+f2B6gxRRqi7x/l8aiH0LCsdCzym2zB7XafBOC9w
 hFpVPIrxXkFRlQnwXU5ZWL9XRxOoS4FFQ9hmBWM18ItkMtiJktg8veW2AxOuGRGJvSWg
 RxEA==
X-Gm-Message-State: AOJu0YyRVd+dG0UtoICJjvelWmJIrTHHiqm0AdbYBR0AnbMLcjC/hGYF
 CO701/F5pW10X8/In5vzgutBUjHeCbDyfZVOxpQbK+DrVIbWIgDsmOIlQizYFzcRac3RIYoZggB
 YU4E8TcWpC5sfW0pYMN6gLzoNw+Nnt7MioGcSAOD1Qq3Yt2N4Se6Hc2xmaFHxMopu835QfuUJ5p
 +AgvsVYcTKjWzLI4DkE4vQ7TvPXaXUt0JtL1f+UvXc
X-Gm-Gg: ASbGncvfgbe61YN4sUSTiH56C9WforfyK/8HYrLU0FSAeT/Il29wbcr/ozLGAFlp8eb
 QGbQhxtA8d/r7lExD9+hkVP8CsHxSZN3gxn5AoOadjCt/I06CEqGDq+Av0+slnrq4e9VAe+0fCr
 e9qdRuPq7PeRlWiVngwtTQMCMH0tkTQreSBZ8JXIwLKSEdV+Iovpm6LO1FpTuXvrG09u3HT+qdC
 GEpcizntoChHh/N4jYfve4wsPxwhinG90gaUU+x5vQiE7SxHww4uAbUn+FRWzVmfmMGmytGDIG8
 k4MEmddWv9pK7OwhaM4AM26FOuE88OrRrjSXR+LfdpIWeLSgnbXUTRszdgDd6yq4YJv63AyLhIM
 sPdz8XElPJHpvg3luolu2z36lg7wgk8cq0appUj67z92f
X-Received: by 2002:a17:906:ee85:b0:b4e:f7cc:6346 with SMTP id
 a640c23a62f3a-b50aa08f852mr1145094266b.15.1760109043931; 
 Fri, 10 Oct 2025 08:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzA8t1uomIKaixAqDtUL/CYFXN/e0VnSTUUNA3/03C1Pr3W1AeWXJOgW2ERfTTqkFLfGj75Q==
X-Received: by 2002:a17:906:ee85:b0:b4e:f7cc:6346 with SMTP id
 a640c23a62f3a-b50aa08f852mr1145090266b.15.1760109043261; 
 Fri, 10 Oct 2025 08:10:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12978sm253940466b.44.2025.10.10.08.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 14/19] scripts/qapi: generate high-level Rust bindings
Date: Fri, 10 Oct 2025 17:09:59 +0200
Message-ID: <20251010151006.791038-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 scripts/qapi/backend.py  |  27 ++-
 scripts/qapi/main.py     |   4 +-
 scripts/qapi/rs.py       | 181 +++++++++++++++++++
 scripts/qapi/rs_types.py | 365 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 577 insertions(+), 4 deletions(-)
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_types.py

diff --git a/meson.build b/meson.build
index afaefa01722..ce914217c52 100644
--- a/meson.build
+++ b/meson.build
@@ -3571,12 +3571,14 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
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
index 49ae6ecdd33..305b62b514c 100644
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
@@ -63,3 +64,27 @@ def generate(self,
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
         gen_introspect(schema, output_dir, prefix, unmask)
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
index 00000000000..2a9bbcb9f54
--- /dev/null
+++ b/scripts/qapi/rs.py
@@ -0,0 +1,181 @@
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
+# see to_upper_case()/to_lower_case() below
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
+def to_upper_case(value: str) -> str:
+    return snake_case.sub(r'_\1', value).upper()
+
+
+def to_lower_case(value: str) -> str:
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
index 00000000000..436adcf5be6
--- /dev/null
+++ b/scripts/qapi/rs_types.py
@@ -0,0 +1,365 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust types generator
+"""
+
+from typing import List, Optional, Set
+
+from .common import mcgen
+from .rs import (
+    QAPISchemaRsVisitor,
+    rs_name,
+    rs_type,
+    to_camel_case,
+    to_lower_case,
+    to_upper_case,
+)
+from .schema import (
+    QAPISchema,
+    QAPISchemaAlternateType,
+    QAPISchemaArrayType,
+    QAPISchemaEnumMember,
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
+        tag_name = var.name
+        patt = '(_)'
+        if type_name == 'q_empty':
+            patt = ''
+        ret += mcgen('''
+    %(cfg)s
+    %(rs_name)sVariant::%(var_name)s%(patt)s => Self::%(tag_name)s,
+''',
+                     cfg=var.ifcond.rsgen(),
+                     rs_name=rs_name(name),
+                     tag_name=rs_name(to_upper_case(tag_name)),
+                     var_name=rs_name(to_camel_case(tag_name)),
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
+#[derive(Clone, Debug, PartialEq)]
+pub enum %(rs_name)sVariant {
+''',
+                cfg=ifcond.rsgen(),
+                rs_name=rs_name(name))
+
+    for var in variants.variants:
+        type_name = var.type.name
+        var_name = rs_name(to_camel_case(var.name), False)
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
+    return [f"{m.ifcond.rsgen()} {rs_name(to_lower_case(m.name))}"
+            for m in members if m.name not in exclude]
+
+
+def has_recursive_type(memb: QAPISchemaType,
+                       name: str,
+                       visited: Set[str]) -> bool:
+    # pylint: disable=too-many-return-statements
+    if name == memb.name:
+        return True
+    if memb.name in visited:
+        return False
+    visited.add(memb.name)
+    if isinstance(memb, QAPISchemaObjectType):
+        if memb.base and has_recursive_type(memb.base, name, visited):
+            return True
+        if memb.branches and \
+                any(has_recursive_type(m.type, name, visited)
+                    for m in memb.branches.variants):
+            return True
+        if any(has_recursive_type(m.type, name, visited)
+               for m in memb.members):
+            return True
+        return any(has_recursive_type(m.type, name, visited)
+                   for m in memb.local_members)
+    if isinstance(memb, QAPISchemaAlternateType):
+        return any(has_recursive_type(m.type, name, visited)
+                   for m in memb.alternatives.variants)
+    if isinstance(memb, QAPISchemaArrayType):
+        return has_recursive_type(memb.element_type, name, visited)
+    return False
+
+
+def gen_struct_members(members: List[QAPISchemaObjectTypeMember],
+                       name: str) -> str:
+    ret = ''
+    for memb in members:
+        is_recursive = has_recursive_type(memb.type, name, set())
+        typ = rs_type(memb.type.c_type(), '',
+                      optional=memb.optional, box=is_recursive)
+        ret += mcgen('''
+    %(cfg)s
+    pub %(rs_name)s: %(rs_type)s,
+''',
+                     cfg=memb.ifcond.rsgen(),
+                     rs_type=typ,
+                     rs_name=rs_name(to_lower_case(memb.name)))
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
+#[derive(Clone, Debug, PartialEq)]
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
+#[derive(Copy, Clone, Debug, PartialEq, common::TryInto)]
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
+                     c_enum=rs_name(to_upper_case(member.name)))
+    # picked the first, since that's what malloc0 does
+    default = rs_name(to_upper_case(enum_members[0].name))
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
+#[derive(Clone, Debug, PartialEq)]
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
+                     rs_type=rs_type(var.type.c_unboxed_type(), '',
+                                     box=is_recursive),
+                     mem_name=rs_name(to_camel_case(var.name)))
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
+// @generated by qapi-gen, DO NOT EDIT
+
+#![allow(unexpected_cfgs)]
+#![allow(non_camel_case_types)]
+#![allow(clippy::empty_structs_with_brackets)]
+#![allow(clippy::large_enum_variant)]
+#![allow(clippy::pub_underscore_fields)]
+
+// Because QAPI structs can contain float, for simplicity we never
+// derive Eq.  Clippy however would complain for those structs
+// that *could* be Eq too.
+#![allow(clippy::derive_partial_eq_without_eq)]
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


