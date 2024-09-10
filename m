Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12381ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so067-0000G2-Ts; Tue, 10 Sep 2024 08:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so05x-0008Id-9a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:47 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so05u-0004qA-Bv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:44 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5365d3f9d34so3950269e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971740; x=1726576540; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YeDbHQv4T6HZDrghSlS7VC8e6ZcGm4D3ignyt0RFSYg=;
 b=oF5SQ5KnWFDlYApOHAztlTwGrbncUQkHc8DQZMEhi155p/CwkFlUHnyR0Mnj+vP2Dq
 7AMZoj1pp3bK/P6I455foMUzOvwE1e4fUBswDolDmSsIeNq8Ynekfo9ETksE2f/u4MYR
 uwdop+ipdZ66THDcXUgoiLNKZEwFr8ZFL4CNcVt0bDs1315sVKk97zhidTVTNZlgjMEa
 dGVPe0d4GmQPn1WrtvNVHOyN6enId+th9KSVrYztUCruSGbHxcMSZbDgvZc65Xp2RGjd
 RtvaDI3JglFE551ycm/d0aT3cektMXbVe3E8RWPe45psOjIesADGFkW+lpe3Xlwkg2/s
 L/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971740; x=1726576540;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeDbHQv4T6HZDrghSlS7VC8e6ZcGm4D3ignyt0RFSYg=;
 b=g+8qRnY/wEyO3fuqnj55q9GyeKcTO21IbJwopnhjXw7PIFfGIVfGy8zRfJjKL9WXl2
 8exyDT0f2KQAX7YdYKgOANzckUInL6L0qS+dAwjnWolPj92bXQQGkNxRRqd4Gothkq7g
 1TOvDmcZ4ZxdZyeOQLhVaSHG2O9qgorWjRCl6SgBdZJJB3DhnZ1iBumSAHkuJh0sn9c3
 PlwEeuZpb7gcOACYGpj1qgCJ3jtuu8M9sBRtgxJ/FO1ukbiq9+ym+LgQl7JSsxmsfh9X
 dgiveyroCyLENHJF7CS4ydlfV/Y238uvcK5mRVvx5KOiNRKJW8RjnGwjq9eQpR5zAqOC
 YODA==
X-Gm-Message-State: AOJu0YzPcGs3rgBi2gD282OwyesDLcfO004zCVWskJn4XCv+T3HnaOFS
 SlkZkP8alZsBBj02j9cmrqONpCJNoP6b+sTmCXNX1YRZcf9+29MIVPnR/TREbWA=
X-Google-Smtp-Source: AGHT+IE2LAfa4o51xATOOOa3rF/PMsYjmcxUTcbyoCCk6LkPRfonLOdnFfHf2SDVfBKPLiH0Dwe9Uw==
X-Received: by 2002:a05:6512:1106:b0:530:e323:b1d0 with SMTP id
 2adb3069b0e04-536587a6854mr9109062e87.9.1725971739905; 
 Tue, 10 Sep 2024 05:35:39 -0700 (PDT)
Received: from [127.0.1.1] (adsl-234.109.242.225.tellas.gr. [109.242.225.234])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cd7sm4242994a12.3.2024.09.10.05.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:35:39 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Sep 2024 15:35:10 +0300
Subject: [PATCH v10 4/9] rust: add bindgen step as a meson dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-rust-pl011-v10-4-85a89ee33c40@linaro.org>
References: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
In-Reply-To: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=9409;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=a/7jQM1JYqtkmdc6Ygg7eiCFRtwOB/WVLF4pner4Mnk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm00RDBNdjJjbzFrTTNEd2VvVDdQU3hnbmZjOWJUCmY2SVNmcFBOZWl2TURDbHp5
 N3FKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnVBOURBQUt
 DUkIzS2Nkd2YzNEowRmpTRC80L1R1TEVmejNMTGwyb3c3YXc0WVVSWnVERnFIZVVpSitrN0hpcA
 o1MDJVeE93YlNyeUpzRGZDbDR5VWZZRExtaGhPekVwWmVYTU10b3pKMDA3N2J4NXhwbThnUTVUL
 1M1NU1Vanl1CktZS1RTV3BlVUpNZ05USUc4bEc3Qy9HNmdBbUdnVXBSUXo0REY3UE1TTC9BSzRL
 cGI3Tk56RS9LZEFnZTdEYjQKaXVRV054dDhSSmVUdVdrVG53bXFpdlBGbDNNZ04yMzhKcGRzYzR
 3VWtDMjJtNTYxci82bTh5VW4vTEdUWUdXRgpUQkdmTDBWK1VuTnNNUDMxSWhDeVFZSEwxMkVTL1
 BJRTk3TUdqN0dvWGVYd0p2VUdNQlRXaEl0NFV1YzMxRjNLCk0wdGozNzMwU0NCaXBkVmdkaWdid
 1ZQVU9rYmF4WGtza01uVzlzbk50cmViR1RIcms3czdYVVllcEtiN1ZSZzQKQzZVVkZqWmpIL3Q1
 RjdyVmMwc3U1c2xIMWk2dzZYVTlSVHU1cmhJa0ZlMWFqelc0aUJaazBBWlUyNDFFMnMzdQpDcXk
 rNDltVnYyNWhQV0RTTzFmTFF0ZUlKR3pCTmY0Uk9YTVVOSzdFNncyOVFvU1FIT3prdEQ4N0hsL3
 hpYmFvClVTMU5RY0ZMQnI0V2VzMlVNcllvRVRzKzBRb0haWXdiUzZ6NC9QLzFqb3hXZEpTV2pEZ
 3VUOEh5ZzYySmphMjcKWjhHdXBVcUg4c2FUYkJ5NVdwUGxaeCswcDVXREViRVd1WEZyVXJYQ25v
 U0E2aElNdVVUZzFzVEo3ZE5zdVk2Ywpjd2NoakRKTkEwMFBlSExFb3puWk1TTXFjNmtHc1FnMlE
 2QXFKSWJnWExmbHRqK0srZU5XM2RhcGJwdnI1U0FzCmNQdmFyQT09Cj16OVozCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12d.google.com
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
 MAINTAINERS                |  4 +++
 configure                  |  7 ++++
 meson.build                | 41 ++++++++++++++++++++++
 rust/wrapper.h             | 47 ++++++++++++++++++++++++++
 rust/.gitignore            |  3 ++
 rust/meson.build           |  0
 scripts/rust/rustc_args.py | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 186 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bc8e515daf7e63320620b52b42a799b99dbe035..642c07a9ff2ed2422ac50d1419751f92f81690bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4246,7 +4246,11 @@ F: docs/devel/docs.rst
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
index 4a011ff60bb8f351b3ee8d038a35a249dc297831..078150046377b6895114e8de3e7b2d4472b2dab8 100755
--- a/configure
+++ b/configure
@@ -2031,3 +2031,10 @@ echo ' "$@"' >>config.status
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
index 065739ccb7300f4f0d487602485802f9f68fb095..1a03f7e15f639799889933c19bf17c2b8f00d879 100644
--- a/meson.build
+++ b/meson.build
@@ -3871,6 +3871,47 @@ common_all = static_library('common',
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
+if have_rust and have_system
+  rustc_config_args = run_command(
+    find_program('scripts/rust/rustc_args.py'),
+    '--config-headers', meson.project_build_root() / 'config-host.h',
+    capture : true,
+    check: true).stdout().strip().split()
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
+    args: [
+      '--disable-header-comment',
+      '--raw-line', '// @generated',
+      '--ctypes-prefix', 'core::ffi',
+      '--formatter', 'rustfmt',
+      '--generate-block',
+      '--generate-cstr',
+      '--impl-debug',
+      '--merge-extern-blocks',
+      '--no-doc-comments',
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
index 0000000000000000000000000000000000000000..77e40213efb686d23f6b768b78602e4337623280
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
index 0000000000000000000000000000000000000000..1bf71b1f68e7791f4b7b40b61fa0fdb5ddbab373
--- /dev/null
+++ b/rust/.gitignore
@@ -0,0 +1,3 @@
+# Ignore any cargo development build artifacts; for qemu-wide builds, all build
+# artifacts will go to the meson build directory.
+target
diff --git a/rust/meson.build b/rust/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
new file mode 100644
index 0000000000000000000000000000000000000000..e4cc9720e16a18cb3f7ad370d4464233336b129a
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
2.45.2


