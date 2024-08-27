Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578C2C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIm-0002jE-4P; Tue, 27 Aug 2024 07:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIg-0002ai-GJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:51 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIe-0000in-3t
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:49 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a868b739cd9so645880366b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757826; x=1725362626; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YuZYhrBMyPn1QnAcNZ8ioMi7TsZgPuclJ/HC7vtKHiU=;
 b=mzg8fl47/HmKVAucVB5rGEXYDreIkgrg7T8jBHJOPyLWSt4X8yFt5J+9/jXusuE0u5
 PEdUgSjLaaI080z3HMSDDoTow0yRYc9jkNWP37ksvzQ6E3Z8dayrxOjEhKTgEviASzyB
 BwSeW4ir5ZEkRwFFRBsQN380TpBRQ4DZao/4CgzsFfuZGtTVQwgDXr9KW4dq20aprIUk
 6Cgpv2Pb37Onn/jRkB+ABLgJ52w8VlLzgZXK+rZHyMc0zqCEXvefbzBAEDnLw5aYWR5G
 kXtrl+yhUSCqeOBYS43MAGvk+Uu+Ce3bMHevA5aL6cer/hfW2iY0m9Vzvdt1h5mJB1c8
 6vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757826; x=1725362626;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuZYhrBMyPn1QnAcNZ8ioMi7TsZgPuclJ/HC7vtKHiU=;
 b=LWsnoQFocPTAUKvMHVl0C2DGkaXh9ZCAEjvmWsp1SO9iky8eXBMJ7Bzy/uaMS5REWO
 kARnHhHjpExGaZsIVJDHnw4hLZz+HiR/aFyZje5NjTFiq5ydqJVl9j85zqGD5MM5e3wX
 5PzcXWPjQL4s+n39/5w5mnBDUg9uS531BJJ85KRxU8iH7dlcBXjfXRVecrMzH/IJcYKm
 xDHpaOhoKS8p3wfiXvcl4XVDJ/YvQ6V9uK32OYtdRLQdHn3deYYeiKc9iStsw04yXXYQ
 /nVfpX1Iz+6wBAFQ2/w6Y4M1btGPLK/HajI2BK39/PXM9bc5jDOBo+uTkfQu/3UaQMCD
 L85w==
X-Gm-Message-State: AOJu0Yxdfw5S11CQV9HBsZ419401+016C6Kp5KxBgettONerz6H3JNxq
 HtVSdGboZyMia/7f/o/KkjtmkyvgJ7/O+DP+konT3cGkziqhTQ2PK1zIrBJIw2U=
X-Google-Smtp-Source: AGHT+IGkudXbnCSwuAn2ZYw8+Jr0buLhD69X2UCgta/Q/fCvn4TSm7HS0XKzCo7QpOTsxvKx+wwfTQ==
X-Received: by 2002:a17:907:8688:b0:a86:a9a4:69fa with SMTP id
 a640c23a62f3a-a86e3be5bf8mr169098766b.43.1724757826021; 
 Tue, 27 Aug 2024 04:23:46 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:45 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:13 +0300
Subject: [PATCH v9 4/9] rust: add bindgen step as a meson dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rust-pl011-v9-4-e90b9c28f861@linaro.org>
References: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
In-Reply-To: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
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
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=7725;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=QShEL48bEPUFi3KY8OJXU63M+qSX9k/RO314TD1AkSo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMwdHFkaE15ZTY2cnpFY211SzhwcTZpOEorCjViVkl6eitOcWFOUnUraXor
 b0NKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05BQUt
 DUkIzS2Nkd2YzNEowTlFIRC85RVFreE90NU5SWFcyU290U2thbkhFSlRYNFZvQVV3ZWZKZHhoZw
 owR0JqRGtQTFViWXhlcDlmZk40ZTdIYjF4RkU3RFFlQzAyYTE1S0tWTUxFY2t3TkJ5bnYyWFVJM
 FRtNXYrTHdoCmJSK3c2Sk4xME1teXB1ejEvdkQ2eW5BQzNDS0ZpWFNTWnQwWHNLNGpyZzljcEFh
 b2s5UUZ6VUpTMGJzcEJXSEoKOGIyL0N1SE1scVl2dGFJQTBIK09iTWNTbE92bGVGZEVEb25CaDB
 rN09KYndmcDI3ajJSaVRFY0FNekFsNUdSUgpwemVKaEI3UDRRVm8rTHh6eVBIeHZWRFVFZklGYl
 VxdytsUkpaKzRMTHhrY1o2V3U0VUppckovcEFBdDRCamd1CmxkZER0dm4rcTZtMWdxTVNSY0lEN
 3ByeE1SaGxzcmQyRllmQlFmQXpRTzhJMitZWkh5SWdWbnB0ZW1veEQvL3EKNlFhUWFRVFNwNUsv
 d1VhQnV5NWV1bEQrUzI5L05GeHF3UFpiOHlHUU90cnhrMllxTXhEZEE0NUdHckRtNVJjZwpWcEV
 XcUNWbGpiTFVWS0NKbkU3U1krMDNzazI3cTZXL2F2clIxUC9YNFdFc25SRmc3REdiTVpNb3FUK2
 dKZHVaCng0dVg3bHVWREdlRmZsVXJhVUhjNWhpZ01ZVWxyUkgxcWNlS2xpVzZXVkl6a2dGQkpES
 W1yckZXMTQyZ095RlcKdkVNeTk1UnBpdWh3TWRGdm1aYnZ5NEtzcUt0YVJ6ZUZ3UFFoeWtzMC9J
 MDhSYmxEMjhEUWl4ZVNMRHpJRElVVwpWZ1pMRmNoSFkvUGlVMnZkVXBHVlBUc1F1UHp4TGY2Kzd
 xbkJMUGg0NWMrOUYzb3djcTFhcy8zR1ZrdCtDVVFrClNaMWhVZz09Cj00SGIvCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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
 MAINTAINERS                |  4 +++
 meson.build                | 34 +++++++++++++++++++
 rust/wrapper.h             | 39 +++++++++++++++++++++
 rust/.gitignore            |  3 ++
 rust/meson.build           |  0
 scripts/rust/rustc_args.py | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 164 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bc8e515da..642c07a9ff 100644
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
diff --git a/meson.build b/meson.build
index 065739ccb7..05446acbc6 100644
--- a/meson.build
+++ b/meson.build
@@ -3871,6 +3871,40 @@ common_all = static_library('common',
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
+if have_rust and have_system
+  rustc_config_args = run_command(
+    find_program('scripts/rust/rustc_args.py'),
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
2.45.2


