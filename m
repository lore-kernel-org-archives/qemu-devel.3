Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F411CF34AF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLtY-0008Tu-9X; Thu, 03 Oct 2024 09:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtV-0008T3-Ik
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtT-0005xh-9q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8ce5db8668so159018866b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727962161; x=1728566961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COLiot0kgdxbDu8qK8bh7okAMTefqr/bJualjgNCU3g=;
 b=uo+8b0MBwqiPYpf1w+Jamp6Jwmxit9fSanLmJ//0bFxJ3WSUIdMJGqQ5/C6hnttsy7
 2qOz7hndKHtY/xjFU8+hapkEJpxs9+5Bm+3aB04BsPg9CDy4W9vy32hF9QWCS/Qb9yzU
 AaJwT98WN+pLWCXjfdedPzo3/XhHiBVakA6AvjmDXDCuM8KZrKaASUXQIT3jJhA/z0mi
 IFsSk3ACEnVpqjhmwmAXfDiTjZlj14/qIsNNT/sjccjWxsruIWg3go1xG0b9YmUGXtNL
 TqZYmIrqmXAgDrIpgTzXQxzMPBmV+LT1S1A6PddmzNJN/j4T1EEPLwl9EQXKalmZFU73
 MKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962161; x=1728566961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COLiot0kgdxbDu8qK8bh7okAMTefqr/bJualjgNCU3g=;
 b=frSpsZO/v5OVNhfFX7j7cW9ic2rtCIgVqJYX3D8PLSvYU6vi0srw9sUXnW567SiiE4
 /sLZyuQ3p+wiQfqfB1vS+qOPsCIUXbExivbujA8YGKrG5g0ZNKDOwB2iWUlp499MFzCc
 y274lTjoNb070RV8iznXXZQfOhLomkO/cqtt6Hfs79mFyZgwaOIsyMBN+u63IK6u6DfA
 7yiqdSiY99/E0uiBg/VODsL4mdoGQh4dKVrHZwrtVZ7oGjn8CBnzJ2jDz+yh4NRbUOL1
 m0ypSphlpNFjnRKpnZPpiG9psQAGGv+4p4xVE9WHcbULNOqdyRbGcFIS76ZZohjMBQG7
 LAsw==
X-Gm-Message-State: AOJu0Yw7JvgaN2kWDcnWMys9kW32D1bD6c1TuX/LmvONkFCWQRB313VN
 wBMNElogioKKImCkBW2TFfuYrXkBSC4EHINyDkRu/IF6y4Ct1HgcAqsFNcQmJaCzgYTLdnB1xbY
 FosA=
X-Google-Smtp-Source: AGHT+IHlHijx8XCgNJFa+BUfNwP3t9j/x7vQTumWJgF8VUma2JhSR8xdQQSol44I4E8+pFoSEYvwGg==
X-Received: by 2002:a17:907:960c:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a98f8207fe8mr691848266b.6.1727962161376; 
 Thu, 03 Oct 2024 06:29:21 -0700 (PDT)
Received: from localhost.localdomain (adsl-122.37.6.160.tellas.gr.
 [37.6.160.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4cdcsm86528366b.57.2024.10.03.06.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:29:21 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, berrange@redhat.com, hi@alyssa.is
Subject: [PATCH v11 4/9] rust: add bindgen step as a meson dependency
Date: Thu,  3 Oct 2024 16:28:46 +0300
Message-ID: <1be89a27719049b7203eaf2eca8bbb75b33f18d4.1727961605.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
References: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                |  4 ++
 configure                  |  7 ++++
 meson.build                | 68 ++++++++++++++++++++++++++++++
 rust/wrapper.h             | 47 +++++++++++++++++++++
 rust/.gitignore            |  3 ++
 rust/meson.build           |  0
 scripts/rust/rustc_args.py | 84 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 213 insertions(+)
 create mode 100644 rust/wrapper.h
 create mode 100644 rust/.gitignore
 create mode 100644 rust/meson.build
 create mode 100644 scripts/rust/rustc_args.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 35278c016a..82a928265c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4198,7 +4198,11 @@ F: docs/devel/docs.rst
 Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
+F: scripts/rust/
+F: rust/.gitignore
 F: rust/Kconfig
+F: rust/meson.build
+F: rust/wrapper.h
 
 Miscellaneous
 -------------
diff --git a/configure b/configure
index 0ccc92074e..4f432e2a70 100755
--- a/configure
+++ b/configure
@@ -2060,3 +2060,10 @@ echo ' "$@"' >>config.status
 chmod +x config.status
 
 rm -r "$TMPDIR1"
+
+if test "$rust" != disabled; then
+  echo '\nINFO: Rust bindings generation with `bindgen` might fail in some cases where'
+  echo 'the detected `libclang` does not match the expected `clang` version/target. In'
+  echo 'this case you must pass the path to `clang` and `libclang` to your build'
+  echo 'command invocation using the environment variables CLANG_PATH and LIBCLANG_PATH'
+fi
diff --git a/meson.build b/meson.build
index 8ddb5fa38d..04fd17bb6b 100644
--- a/meson.build
+++ b/meson.build
@@ -3899,6 +3899,74 @@ common_all = static_library('common',
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
+if have_rust and have_system
+  rustc_args = run_command(
+    find_program('scripts/rust/rustc_args.py'),
+    '--config-headers', meson.project_build_root() / 'config-host.h',
+    capture : true,
+    check: true).stdout().strip().split()
+  rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
+  bindgen_args = [
+    '--disable-header-comment',
+    '--raw-line', '// @generated',
+    '--ctypes-prefix', 'core::ffi',
+    '--formatter', 'rustfmt',
+    '--generate-block',
+    '--generate-cstr',
+    '--impl-debug',
+    '--merge-extern-blocks',
+    '--no-doc-comments',
+    '--use-core',
+    '--with-derive-default',
+    '--no-size_t-is-usize',
+    '--no-layout-tests',
+    '--no-prepend-enum-name',
+    '--allowlist-file', meson.project_source_root() + '/include/.*',
+    '--allowlist-file', meson.project_source_root() + '/.*',
+    '--allowlist-file', meson.project_build_root() + '/.*'
+    ]
+  c_enums = [
+    'DeviceCategory',
+    'GpioPolarity',
+    'MachineInitPhase',
+    'MemoryDeviceInfoKind',
+    'MigrationPolicy',
+    'MigrationPriority',
+    'QEMUChrEvent',
+    'QEMUClockType',
+    'device_endian',
+    'module_init_type',
+  ]
+  foreach enum : c_enums
+    bindgen_args += ['--rustified-enum', enum]
+  endforeach
+  c_bitfields = [
+    'ClockEvent',
+    'VMStateFlags',
+  ]
+  foreach enum : c_bitfields
+    bindgen_args += ['--bitfield-enum', enum]
+  endforeach
+
+  # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+  #
+  # Rust bindings generation with `bindgen` might fail in some cases where the
+  # detected `libclang` does not match the expected `clang` version/target. In
+  # this case you must pass the path to `clang` and `libclang` to your build
+  # command invocation using the environment variables CLANG_PATH and
+  # LIBCLANG_PATH
+  bindings_rs = import('rust').bindgen(
+    input: 'rust/wrapper.h',
+    dependencies: common_ss.all_dependencies(),
+    output: 'bindings.rs',
+    include_directories: include_directories('.', 'include'),
+    bindgen_version: ['>=0.69.4'],
+    args: bindgen_args,
+    )
+  subdir('rust')
+endif
+
+
 feature_to_c = find_program('scripts/feature_to_c.py')
 
 if host_os == 'darwin'
diff --git a/rust/wrapper.h b/rust/wrapper.h
new file mode 100644
index 0000000000..77e40213ef
--- /dev/null
+++ b/rust/wrapper.h
@@ -0,0 +1,47 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
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
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
new file mode 100644
index 0000000000..e4cc9720e1
--- /dev/null
+++ b/scripts/rust/rustc_args.py
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


