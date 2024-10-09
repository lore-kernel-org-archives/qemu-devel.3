Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE557CF0438
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHj-0001AP-G8; Wed, 09 Oct 2024 05:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHP-00015i-Ck
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHH-0008Pk-6E
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6AH7uxwpx1XC/pKMMigbfIQX3I6aLPst/jy/5LYqoQ=;
 b=HokKsT1i9XnXX0lNMMrgVypA4s3qzaDcY6T6NEj5enBBkv5zIiDDxTTSpyu/HXpnK2V5WJ
 BfGpIYWyHRpblZNCIXvQwZMg0MDFgeNG515pJum+qK/4cit0Jgm6nPZY+sm2SF48jtCU/R
 TBuFwUMpv4AqwB4iFeVSwpHvLADv5EY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-qMH29wu3NGClK5ug2OnQAw-1; Wed, 09 Oct 2024 05:46:41 -0400
X-MC-Unique: qMH29wu3NGClK5ug2OnQAw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43111c47d0bso2991675e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467199; x=1729071999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6AH7uxwpx1XC/pKMMigbfIQX3I6aLPst/jy/5LYqoQ=;
 b=DU6RTK+zjmLVdNrf51KnUU5SUWNTmJeBBiFU79XcsblL7OwovN6oxG7qKH9xmqJYwa
 RHucEjoCwJhTFRUSXtfQsLjH49uqsHfL+ndBeEpGFHlYDsac0yRz02fZFSFdIgm4EcUL
 TCJYgRQhcngCeXgGKZHstiQKOD/78s/8xRrMWuPmOnQLNBchrLd9qA9N80MevbzZ3Xb8
 u2HgqKC4jSZqydh4w1o9GVPvcXQwZoUNtBjDLl7ZNtJ4tRYKI/YtZSZ74vmqEFOGOqP7
 G8mkfPvOsIpSufu8IkQQT2/u67nOyRKRPUIqds6QsbeLACf6JA722DoUQvuO/V9pJ6by
 mqDQ==
X-Gm-Message-State: AOJu0YwUsLWZ5qy8uKkPR+5keeCQCvdCPVdsW8Bbdg4qtM8MYOTF93l4
 FGcpPiKT9EY7T2hN9wMgSWVRg6h3V5LHx8PHon2J/abknlbN57s26e1NeR8eCTB0FFCRxq0faQM
 +gYPp+tO8Fre9pNjWB8W/usMOa3NDWZD/BqUQMC1e2z5aBM1vYPoAN29jsoHvgdRfeOT1Cpn6TS
 mxJ0E+uRCFF7WX9XrJrh6q3x/UuSL0tq9Gr7cVAyg=
X-Received: by 2002:a05:600c:45d1:b0:42f:80f4:ab31 with SMTP id
 5b1f17b1804b1-430ccf4757emr10398555e9.18.1728467199145; 
 Wed, 09 Oct 2024 02:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKFmkz/wMgsKwmPAqDhx0aSR86x6yX8FkSlgda7MzmMuF1LgkAryfTuxWfXwCCOrUnOm8xWQ==
X-Received: by 2002:a05:600c:45d1:b0:42f:80f4:ab31 with SMTP id
 5b1f17b1804b1-430ccf4757emr10398355e9.18.1728467198588; 
 Wed, 09 Oct 2024 02:46:38 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf1f776sm14786875e9.3.2024.10.09.02.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:46:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 04/14] rust: add bindgen step as a meson dependency
Date: Wed,  9 Oct 2024 11:46:05 +0200
Message-ID: <20241009094616.1648511-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add bindings_rs target for generating rust bindings to target-independent
qemu C APIs.

The bindings need be created before any rust crate that uses them is
compiled.

The bindings.rs file will end up in BUILDDIR/bindings.rs and have the
same name as a target:

  ninja bindings.rs

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/1be89a27719049b7203eaf2eca8bbb75b33f18d4.1727961605.git.manos.pitsidianakis@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index fb3188c053e..f09029560b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4191,7 +4191,11 @@ F: docs/devel/docs.rst
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
index 6cc3d6b4793..4649da749e9 100755
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
index f76f01f065f..b9a83dfc744 100644
--- a/meson.build
+++ b/meson.build
@@ -3892,6 +3892,74 @@ common_all = static_library('common',
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
index 00000000000..77e40213efb
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
index 00000000000..1bf71b1f68e
--- /dev/null
+++ b/rust/.gitignore
@@ -0,0 +1,3 @@
+# Ignore any cargo development build artifacts; for qemu-wide builds, all build
+# artifacts will go to the meson build directory.
+target
diff --git a/rust/meson.build b/rust/meson.build
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
new file mode 100644
index 00000000000..e4cc9720e16
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
2.46.2


