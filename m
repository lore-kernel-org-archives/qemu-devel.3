Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D74C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjA2m-0005eH-AH; Wed, 28 Aug 2024 00:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2j-0005Xx-5P
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:25 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2g-0000lj-OL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:24 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5bed83487aeso6445871a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724818341; x=1725423141; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RIA2mzchFzu/rUsSqz24xC7Y44yMs6m0u27dIMBYc38=;
 b=t5A8+XmSlfCJS4vgQar51xkbMII7VeKqkM1ztWtbO4xlNoL0VJ7nM+maGkzr2mVhIh
 3nW6rWvZeJVhxDGUpE4cgVRLV8+aNtZcNEYoVbsubCwu8KdCA8NHGFb+Y7yqKeYUsieV
 MwBJQY9GsJyL8M0fTkxIAEusZt733kgD1dy/0Gocfm9zEyho1g2t6EsZOQKTkvrUWM2Z
 eY6GwVh2MExNhDWlBWWdOS36Q+ouATFFhcmB+kcGiMPhVcqeGBaietc2PR7814qNqnFv
 wExJuZkttvY7s0lWDG4eMVuGEcucBT5NiZznq4jLoivsXfhJjrdGImk22kFGPQNbPWPx
 7oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724818341; x=1725423141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIA2mzchFzu/rUsSqz24xC7Y44yMs6m0u27dIMBYc38=;
 b=URxyz7LnWjxCxz8hOwrYgAKSY19VkHpUtqYVKuHldBzIiOk3tQjU7T9ZkOo+PNKJXy
 W4hUlt0cbz8wnqlonKJJVkzMaGsUJZY147E0P+TtXriFEGW4dL9uR159occXDTcPwGXy
 GBPCv8PaeOonfIc0oxIpl7AQBBhj+iy4pqRjJRPSqdl5y1vmkYw4LTVjOjXOntkEU0aK
 h8A6OYIvgNs3xO9kuuBpbUp6Qfc5b34Uv6f407xvdAVUx8yKZTUGKbEA75jn5nBm8CQH
 u8Bn9b61mpYqmPuVgomrSQg2sxdy5ALQL1OrtJtuJ7AOC4HO21hsEcF1CM/KHVLoPjFz
 iiKw==
X-Gm-Message-State: AOJu0YzOpmb690TkAHC2hjLr8xG1iYLuOC0j52rXB53dse9B5UMPVuMT
 ujbK/XhaD95SWULVRqQiObc0Wh//W7YyjE3MBdwRndqs9JCsG2SQzEekF7c+V/c=
X-Google-Smtp-Source: AGHT+IGKtYLx6YS+1gz4uUlPfaPg/3NOAO1eIcUXua0DthPh2OnRIR+HH3o3EVA/Iwh/CYLv5H+rnA==
X-Received: by 2002:a05:6402:2187:b0:5a4:6dec:cd41 with SMTP id
 4fb4d7f45d1cf-5c214c55462mr415481a12.28.1724818340602; 
 Tue, 27 Aug 2024 21:12:20 -0700 (PDT)
Received: from [127.0.1.1] (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb1c29b9sm1712814a12.18.2024.08.27.21.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:12:20 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 28 Aug 2024 07:11:45 +0300
Subject: [PATCH RESEND v9 4/9] rust: add bindgen step as a meson dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-rust-pl011-v9-4-35579191f17c@linaro.org>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
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
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=8085;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=PQJSezN8Fa5GrXoUGvLqQ4JAqn06+ukoNNi+seooUts=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16cU9MZW95OUtReHZuUUt2M3hma2kwcnAwQm9uCjRtc2ZheFhlVElJSy9YT3VZ
 QWVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnM2aml3QUt
 DUkIzS2Nkd2YzNEowQnZDRC85ckVGcVd6alJqTTdaaGJwQkVMbzVmTHhCSEE1MHlsWUZwQWlkeQ
 poOGIzVjZINDk1TlUvcXJ0RXN3Nkt3VFNIa2xSdjFYT3JRMWJkallIblJhcW9xOUpubEpTcUVOQ
 ldUd3d4bTJVCmZLdUtqYm1oSUthdWtkR1JsQ25GOE5DbGV6cWZQWWZ2L0hVaGdPdVZGYmFHd0ll
 SSs4cXljRHQwUUVORTl3azMKeU9IeUJZdXFrSEwxQ2p4Rjc3SkhMTnJuSXZNTlQwblQ4S1YxS0V
 BaStlZGRiRSs1N01kalA0OWRLZGY1cE1SOQp1bjhxNVVOS3c2OGZkZC9SN2V5UU9zNGNoMXVheG
 lMY21PVkpDSE55dUFta2gyNFcxeDJjT0cvem8rbzVkYTR3CjArbDNmM05rdmNLdkNISlRMWkE0O
 EwyZUFsSGwzK3BvUUNNS0gwSEt0MlcxUFRHQlVIMm42MHlkNnU1WDdyd00KZkxBdEI2cDBKNmNn
 WmZjQkNpZTdDZlFCOGN0Uy96cWdvN3p6ZXA1azU2VVl3Z1owVys1NkhTelZFR1prRmVyUgpIc2p
 PSHJFSVVndVVKRlFZUW5zN0w4UEQ3RndPM20ycUgrUlhGVFpnVStDeVVjY2VYcnNlQVBGWDNWM0
 F4eU01CllyeTZMZmRGbEJPWFdkL0Y3MlpUSVBqY1hzOFFzYzhjZ3NTcW4rdU1wRzJWK2pQZG1ZO
 XdlWDQ2c3lHY3doQTkKNGlZUGRVZ0piaWR0bm1RdVpXRDVaSy9oeVAwamdQSFF5Q3JqOXpBOE5L
 VzhUSlZLSUxuYUZ6SU1abldkSWp0bApQMGVnaXpHZHZ4Qms5d3JheFNrYXlFOG9ybnRuQUJ1R3I
 wQUZwcGRJeDEvNnhRTndDWVFtWms5Z3VhbW9mSm5ECkdYWGJOUT09Cj04cENjCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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
diff --git a/meson.build b/meson.build
index 065739ccb7300f4f0d487602485802f9f68fb095..05446acbc684a7521ecc9b3f80b98e2cec1a60cf 100644
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
index 0000000000000000000000000000000000000000..51985f0ef1550a7e0eb8b2ea5273a832fed8eec8
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


