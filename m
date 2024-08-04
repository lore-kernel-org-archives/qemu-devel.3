Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9EFC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiP7-0008SU-6k; Sun, 04 Aug 2024 17:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiP4-0008Jk-J3
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:34 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiP2-0005fQ-9v
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:34 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135dso2455246a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722805470; x=1723410270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qn3mGXnmhMG+A80ZK0JJrAwRkG85xoS/9ALggp/piZw=;
 b=BB/UL84eLTL9EoHAsgnh6jDpVsqiESApbORMhMkoHTqwzJ5InwelDPu90L5iEgQ875
 7HWNRzEkRv3zNvWN5mZ7IEkty3UDu4fZyjUmXZrCoooTafAhV1LkDJbGD0i4fE6UX9Hu
 ExD17tE7Bzlsaq+P5HO9vfNRKBm66uXNnG9iYEio0AupHeIquayjUWmqKmc28rwZwC24
 wPOOu3TsGyzGwz7FNGiSBJ2hMBM1wHHhOZGbrDLdHEY8/LoBr4cAS/K2x0/DMj1u17EX
 Zzr4GrgJdcKBJ2FtoDrqbYELWIOH/eyKliUr9WbssdEckuU24haEiogQORt9HJRIHtnw
 7n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722805470; x=1723410270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qn3mGXnmhMG+A80ZK0JJrAwRkG85xoS/9ALggp/piZw=;
 b=D2+1P6r1hvYTWzUufJP6YOVIpvyBQIyDm0oj+8NKx+ggp3ey/5CGv4dA5kmfWF2/GN
 A3GSNa9YYKHWfj9t5QOlGccZYHeB5H7UW+fRCOgXZJ1gY02ZkSofZ/y6IYrEoNe5Y8OY
 rmYFHVFk0NKr+7CPrdaS0BVPZEuB9X6UTeKC6bfVpKwCj1ukFBKD3D1xHpwq9T66rGtZ
 LH9ZDyNYcZjfO16E2ok3+0MZIgHGzbHcJ8kYUi08SewKSgtoE/EFIHGZ8bxLURIJ2OL1
 MirirOWvG6thaIpPXfnxotVml/LaZgKOTEJUrf/27h8IrbbLBKd857oA5u92YN/oTklZ
 L2YQ==
X-Gm-Message-State: AOJu0YwaljT/GXrZvqU5TbHnGXt8TgI+6It080pt197R7Lxt9A+A7TJ2
 PbV/INpCXoe+jHkNzTu8qE2ik1LLtidfxx4/kvHXVvzNMwE2hoLI5JhlIuw3Q0Gqmc9Siyo2my7
 tizQ=
X-Google-Smtp-Source: AGHT+IGa59LpJgQBXELaYgbxPhCUCt1hOaWVb6AbDpSr/jRKbue1ra1/Z9V8HKT+JhuSSXVqxrd0Ew==
X-Received: by 2002:a17:906:d247:b0:a7a:a763:8438 with SMTP id
 a640c23a62f3a-a7dc509f93fmr651553566b.55.1722805470346; 
 Sun, 04 Aug 2024 14:04:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-146.37.6.160.tellas.gr.
 [37.6.160.146]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d437a5sm366348766b.101.2024.08.04.14.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 14:04:30 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v6 2/5] rust: add bindgen step as a meson dependency
Date: Mon,  5 Aug 2024 00:04:13 +0300
Message-ID: <rust-pl011-rfc-v6-2.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

Add bindings_rs target for generating rust bindings to target-independent
qemu C APIs.

The bindings need be created before any rust crate that uses them is
compiled.

The bindings.rs file will end up in BUILDDIR/bindings.rs and have the
same name as a target:

  ninja bindings.rs

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS           |  4 +++
 meson.build           | 52 +++++++++++++++++++++++++++
 rust/wrapper.h        | 39 ++++++++++++++++++++
 rust/.gitignore       |  3 ++
 rust/meson.build      |  0
 scripts/rustc_args.py | 84 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 182 insertions(+)
 create mode 100644 rust/wrapper.h
 create mode 100644 rust/.gitignore
 create mode 100644 rust/meson.build
 create mode 100644 scripts/rustc_args.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ba57c9c67..e1d77816bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4242,7 +4242,11 @@ F: docs/devel/docs.rst
 Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
+F: scripts/rustc_args.py
+F: rust/.gitignore
 F: rust/Kconfig
+F: rust/meson.build
+F: rust/wrapper.h
 
 Miscellaneous
 -------------
diff --git a/meson.build b/meson.build
index 9593fce47f..19f32bb67c 100644
--- a/meson.build
+++ b/meson.build
@@ -306,6 +306,15 @@ foreach lang : all_languages
   endif
 endforeach
 
+if have_rust
+  rust_args = []
+  if get_option('debug')
+    rust_args += ['-g']
+  endif
+  if get_option('optimization') not in ['0', '1', 'g']
+    rust_args += ['-O']
+  endif
+endif
 # default flags for all hosts
 # We use -fwrapv to tell the compiler that we require a C dialect where
 # left shift of signed integers is well defined and has the expected
@@ -3860,6 +3869,49 @@ common_all = static_library('common',
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
+if have_rust and have_system
+  rust_args += run_command(
+    meson.global_source_root() / 'scripts/rustc_args.py',
+    '--config-headers', meson.project_build_root() / 'config-host.h',
+    capture : true,
+    check: true).stdout().strip().split()
+
+  bindings_rs = import('rust').bindgen(
+    input: 'rust/wrapper.h',
+    dependencies: common_ss.all_dependencies(),
+    output: 'bindings.rs',
+    include_directories: include_directories('.', 'include'),
+    bindgen_version: ['>=0.69.4'],
+    args: [
+      '--raw-line', '#![allow(dead_code)]',
+      '--raw-line', '#![allow(non_camel_case_types)]',
+      '--raw-line', '#![allow(non_snake_case)]',
+      '--raw-line', '#![allow(non_upper_case_globals)]',
+      '--raw-line', '#![allow(improper_ctypes_definitions)]',
+      '--raw-line', '#![allow(improper_ctypes)]',
+      '--raw-line', 'unsafe impl Send for Property {}',
+      '--raw-line', 'unsafe impl Sync for Property {}',
+      '--raw-line', 'unsafe impl Sync for TypeInfo {}',
+      '--raw-line', 'unsafe impl Sync for VMStateDescription {}',
+      '--ctypes-prefix', 'core::ffi',
+      '--formatter', 'rustfmt',
+      '--generate-block',
+      '--generate-cstr',
+      '--impl-debug',
+      '--merge-extern-blocks',
+      '--no-doc-comments',
+      '--no-include-path-detection',
+      '--use-core',
+      '--with-derive-default',
+      '--allowlist-file', meson.project_source_root() + '/include/.*',
+      '--allowlist-file', meson.project_source_root() + '/.*',
+      '--allowlist-file', meson.project_build_root() + '/.*'
+      ],
+    )
+  subdir('rust')
+endif
+
+
 feature_to_c = find_program('scripts/feature_to_c.py')
 
 if host_os == 'darwin'
diff --git a/rust/wrapper.h b/rust/wrapper.h
new file mode 100644
index 0000000000..51985f0ef1
--- /dev/null
+++ b/rust/wrapper.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu-io.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "exec/memory.h"
+#include "chardev/char-fe.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/irq.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "chardev/char-serial.h"
diff --git a/rust/.gitignore b/rust/.gitignore
new file mode 100644
index 0000000000..1bf71b1f68
--- /dev/null
+++ b/rust/.gitignore
@@ -0,0 +1,3 @@
+# Ignore any cargo development build artifacts; for qemu-wide builds, all build
+# artifacts will go to the meson build directory.
+target
diff --git a/rust/meson.build b/rust/meson.build
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/scripts/rustc_args.py b/scripts/rustc_args.py
new file mode 100644
index 0000000000..e4cc9720e1
--- /dev/null
+++ b/scripts/rustc_args.py
@@ -0,0 +1,84 @@
+#!/usr/bin/env python3
+
+"""Generate rustc arguments for meson rust builds.
+
+This program generates --cfg compile flags for the configuration headers passed
+as arguments.
+
+Copyright (c) 2024 Linaro Ltd.
+
+Authors:
+ Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program.  If not, see <http://www.gnu.org/licenses/>.
+"""
+
+import argparse
+import logging
+
+from typing import List
+
+
+def generate_cfg_flags(header: str) -> List[str]:
+    """Converts defines from config[..].h headers to rustc --cfg flags."""
+
+    def cfg_name(name: str) -> str:
+        """Filter function for C #defines"""
+        if (
+            name.startswith("CONFIG_")
+            or name.startswith("TARGET_")
+            or name.startswith("HAVE_")
+        ):
+            return name
+        return ""
+
+    with open(header, encoding="utf-8") as cfg:
+        config = [l.split()[1:] for l in cfg if l.startswith("#define")]
+
+    cfg_list = []
+    for cfg in config:
+        name = cfg_name(cfg[0])
+        if not name:
+            continue
+        if len(cfg) >= 2 and cfg[1] != "1":
+            continue
+        cfg_list.append("--cfg")
+        cfg_list.append(name)
+    return cfg_list
+
+
+def main() -> None:
+    # pylint: disable=missing-function-docstring
+    parser = argparse.ArgumentParser()
+    parser.add_argument("-v", "--verbose", action="store_true")
+    parser.add_argument(
+        "--config-headers",
+        metavar="CONFIG_HEADER",
+        action="append",
+        dest="config_headers",
+        help="paths to any configuration C headers (*.h files), if any",
+        required=False,
+        default=[],
+    )
+    args = parser.parse_args()
+    if args.verbose:
+        logging.basicConfig(level=logging.DEBUG)
+    logging.debug("args: %s", args)
+    for header in args.config_headers:
+        for tok in generate_cfg_flags(header):
+            print(tok)
+
+
+if __name__ == "__main__":
+    main()
-- 
γαῖα πυρί μιχθήτω


