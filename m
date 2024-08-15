Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291DBC52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYse-0008Uh-QC; Thu, 15 Aug 2024 07:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsd-0008Qq-NX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:59 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsb-0002ER-9d
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:59 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso1321509e87.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722175; x=1724326975; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Yj9hQIIF1FTjGHS44YcyZPrJjc2WJIemrC3mw1WIUU=;
 b=dhiKF2BozjPuiRrhJiTzHgvQ9YroksU6RlWxiiD718jzDqtwaV1I5UEw3WYjfi2FMo
 oK/ivF04kT56lqwhwK3+HvH3odqQxUnIcz3qajFeGuZc3l5BraCLLGMwb0iavBWWvq5R
 YEtCUZ6UzMAsD0L+e+f6C5S2oCoWJcwudCpLNPi91gWLNsfHdRsi1L/7JFo1OERA8Lsa
 C01oesmsQ6iMc31cwtlrn9husTAoxCAjUS2x6dqdrgQ1lzbKIG4LexhBMdsCA/S2ObDX
 fRmAJEtU2sQl5rX6TDM/n2XMHVDwBeTQBZfkjUO/phoYxCHnQenBxIl8FS7Mj+eVkqKU
 v1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722175; x=1724326975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Yj9hQIIF1FTjGHS44YcyZPrJjc2WJIemrC3mw1WIUU=;
 b=bEJmz4ngAAVqdDb/BIwPw82U7oLZTClFXP0YOJDVNfAnysSeQ9Q8ij6Lp4JVM6eAGc
 TspX1pLBsHJtsjQIsSrvw5dtMPMiVCvtArvELKQmS5jnndIvRUtzg9f4i/bU3xidpmfX
 +eIon7tlLtOUS/RIATmfcerRwKtRTa04WcaWw44KB+d1YPlUy/o1ASl/Ugl5M/cEhimf
 /CADH7H/IokFhPuDp1o9tGNW+YMSzrlN5ez8jFR/ziUyCTGPotQaO1hZtDhISKyQKQLg
 gTuZI3JGD8dEbhtn1X42TcG1gQ0K/Qq5JeB4YbUUB8s652TkhsaQRhdjZlnubVhqb37V
 bd5Q==
X-Gm-Message-State: AOJu0YyiZ6qyeAmScZtbagChpofsJQmnwSvnsk8pW4+eY9UAuf2xBL5Y
 e/tC9hkZmWy4LHU25X1TbdrQBVCdwVKVAfgc/3H+TCjx3EIQYjv71ZMKUA28y4zGQNehqyNNEET
 Y+6g=
X-Google-Smtp-Source: AGHT+IHsRoL1yab0jqA8VzE+0U2IiriDN0IMhp8jLT25IG/elkyuxB9/A0vQv89XDlPP3XZaoSiORg==
X-Received: by 2002:a05:6512:68b:b0:530:a9fe:7bb6 with SMTP id
 2adb3069b0e04-532eda8a8bemr3468229e87.30.1723722175329; 
 Thu, 15 Aug 2024 04:42:55 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bf1sm89547966b.21.2024.08.15.04.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:42:55 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 15 Aug 2024 14:42:21 +0300
Subject: [PATCH v7 4/7] rust: add bindgen step as a meson dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-rust-pl011-v7-4-975135e98831@linaro.org>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8698;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=5pohEWpxNu7gHtQAi85K36q37MBA+ZAUTSdPnlTjkwQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm12ZW11MXFsdE9wRGQxQnlJb1dBenNxMy93bStLCnJkUFQ3V1lXSGJoaGZ0a2Yw
 OHFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnIzcHJnQUt
 DUkIzS2Nkd2YzNEowUHAzRC85SkYzN25ab0tKbVJWRWMzRnozblVGN3NKaXVWV1U2NStDSFkrMg
 pzLzhEd1RoT0dDOGtoUFpwVDVSTmRCR1ZZM01ud2xTS1V5NTBxdjAzVUxWVmloRTRlUXJFNUdGd
 GNaeXdzOUJwCkNVenBGTnA4UVZreFR6STlIc25kVzBFUFlVZ0tQbTRyVEFpSFdNSDdpKy9vVllD
 ckRwb0hTaktmQ2M1aFNXbFcKWkc5RUxNMHJ3d2JGMk9DUjMrT1hNZGp1bGpuNXBjT2p6WlhiMTR
 jcDVDVTBGVGs0VlVPQ1NVVyt4QjR1WmdjRApvcGpxOGdRc2g5Rk5WQ1cyYlhNbjhQampSeU9QcX
 FTcVlzQnN0dGJwL1EzRk1uMFBQRXhMSTBubk9wcW1FYnZOClpKKy91UU1sVnNYQVhEY1NRbittS
 0VFekdxbmw0UjUwSXJLUXN4ZEdOdUIwQ3JBNUdSbG5Pay9FNCtocS8zSkwKNXBCRk44UVVMU2Vj
 cFBhdCtIN3hRbjlBTTZNMlRiY3ZtQ1VmcjNBQUhTU0l3Rjk3SGJZY21KRlkvWUlxMXUxSwpnN2d
 Ma203THh2aTdpQzlsbVllejJPbHRUanAxVmdxTjNPMVFQWTZzZzJmSUlZT05aK29VSlR1cUV5aE
 lhaG9VCk1oNzBWN2VlTjJ5OXM3RTI3TnV0ektaUmJOZ3l3bzFsQ1NkNEMyS3ZBTVFESGlsWlpKM
 0JNV0hIbS91SURJOGQKc3pQM0ZpVXlWV1F5RVZMVGdoSEFZSUlOeHEwUVlSK1dadCs1dFh4VTZt
 QnhFUzJJdHJNdGo0dDRIVi95NER6bQowMXRXT1VncStPQ1JzR05EcEJ6bUxYaXVobmllUGpORUF
 0RDhNYjdiMCtKZlh5TW5zODEwL3B5b3BJTWtlZXRUCmk4b2hmdz09Cj0za1VpCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 MAINTAINERS           |  4 +++
 meson.build           | 52 +++++++++++++++++++++++++++++++
 rust/wrapper.h        | 39 ++++++++++++++++++++++++
 rust/.gitignore       |  3 ++
 rust/meson.build      |  0
 scripts/rustc_args.py | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 182 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bc8e515da..5464cb2b03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4246,7 +4246,11 @@ F: docs/devel/docs.rst
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
index 065739ccb7..10a8f25068 100644
--- a/meson.build
+++ b/meson.build
@@ -303,6 +303,15 @@ foreach lang : all_languages
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
@@ -3871,6 +3880,49 @@ common_all = static_library('common',
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
+      '--raw-line', '// @generated',
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
2.44.0


