Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7742D597A8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAyPQ-0003iD-HC; Tue, 12 Nov 2024 16:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPI-0003hH-TG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tAyPH-0004TB-2P
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:26:40 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d5aedd177so3586315f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731446796; x=1732051596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/StD3IgdHph1GnsDJB+ee0l75mNWFNIYbQ7+87JHqMU=;
 b=AR3jRnOsHCp9x3bCd3u5ggsppdk5oV8s2bpHxMdze0kN7b2rKkAxKfxDLzPgIPsQpy
 w0a85nza+WHp6+Pe2GpcsQ3g7GaV3mYALd18aGGh4HM0s/NH5u6fKm73txrj2vrQGcda
 lZ0JkIkwC7Jp+sIg8/e3Yb9q/kgORpg06CrMxUL5TaJcTnIqXAdYZQiT4fTAuRi8221k
 ne/aKwNqrNyipgQbomHmYr/oZTz5YUl3Y1Z3vq8qDeH0+GlBg9aMqH+uljcVasdNoun2
 LL9cCILLBB1vrACGYgAmsztrcYRou0iqfLvQgf6bVcTz5a565YrshXI4mZ9C0FRRyB7n
 XH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731446796; x=1732051596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/StD3IgdHph1GnsDJB+ee0l75mNWFNIYbQ7+87JHqMU=;
 b=hgbj7sWQ25DapiwSfw1VXwhhhTchqIZnOJEeCgsp93WsiL3kWr3NG9pL8CZaTfGueX
 9vLLrOn0p9QVpg8ADSj+9doRxAh2VD5jDjBG9r/cHiiu5fagDiI//Bkr7PyXK2pnfrv1
 8RNmoStW8uT3ZmZtVPLv6glnurb7l5Bje7WhBJTlLO/KCUiv5vJn1iBkzULoK0wpI8dZ
 WIt5EAeb59VofAE6q1n8hTWduNV6QJAKOT35oVJ+aMW4EpAWQS4qgJO4C8p7rZqXWYkf
 LovqgQQutRFeWDFOxC1Xm7CB+j6iYQqOqEzjVbLw1TovvlrVfDEgm8g4jS+x/HU+fuJy
 Ux1w==
X-Gm-Message-State: AOJu0YxlJ1SJu+Oo/xjbFQdTTNa/JX9A4vvztXrGtFh17I8AqWqeGVH3
 2IHOlO2JO9ui3p2WC1QzCPdpZLtSJLGsv+7otHVZv6BpqHQU8olS3CSqzE1G2PZ/Il2aIt3qTbs
 PKUSk1Q==
X-Google-Smtp-Source: AGHT+IGDjA/mRoJetReZ/K2tKXU9v4vFqOueoIvjmQcQSpKiBIp+hsmfNx+KCx9XO+ryYSenUNdHyg==
X-Received: by 2002:a5d:6d89:0:b0:381:ebac:2c5e with SMTP id
 ffacd0b85a97d-3820df61014mr405994f8f.14.1731446796329; 
 Tue, 12 Nov 2024 13:26:36 -0800 (PST)
Received: from linaro.. ([193.32.126.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ec202sm16613515f8f.83.2024.11.12.13.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:26:36 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 2/3] plugins: detect qemu plugin API symbols from header
Date: Tue, 12 Nov 2024 13:26:21 -0800
Message-Id: <20241112212622.3590693-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
References: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x429.google.com
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

Instead of using a static file (error prone and hard to keep in sync),
we generate it using a script.

Note: if a symbol is not exported, we'll now notice it when linking for
Windows/MacOS platforms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                    |  1 +
 plugins/meson.build            | 12 ++++++---
 scripts/qemu-plugin-symbols.py | 45 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)
 create mode 100755 scripts/qemu-plugin-symbols.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0e..7d6d2bd59e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3747,6 +3747,7 @@ F: plugins/
 F: tests/tcg/plugins/
 F: tests/functional/test_aarch64_tcg_plugins.py
 F: contrib/plugins/
+F: scripts/qemu-plugin-symbols.py
 
 AArch64 TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/plugins/meson.build b/plugins/meson.build
index 1cc039d29b2..98542e926f8 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -2,17 +2,23 @@ if not get_option('plugins')
   subdir_done()
 endif
 
+qemu_plugin_symbols = configure_file(
+  input: files('../include/qemu/qemu-plugin.h'),
+  output: 'qemu-plugin.symbols',
+  capture: true,
+  command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
+
 # Modules need more symbols than just those in plugins/qemu-plugins.symbols
 if not enable_modules
   if host_os == 'darwin'
     configure_file(
-      input: files('qemu-plugins.symbols'),
+      input: qemu_plugin_symbols,
       output: 'qemu-plugins-ld64.symbols',
       capture: true,
       command: ['sed', '-ne', 's/^[[:space:]]*\\(qemu_.*\\);/_\\1/p', '@INPUT@'])
     emulator_link_args += ['-Wl,-exported_symbols_list,plugins/qemu-plugins-ld64.symbols']
   else
-    emulator_link_args += ['-Xlinker', '--dynamic-list=' + (meson.project_source_root() / 'plugins/qemu-plugins.symbols')]
+    emulator_link_args += ['-Xlinker', '--dynamic-list=' + qemu_plugin_symbols.full_path()]
   endif
 endif
 
@@ -23,7 +29,7 @@ if host_os == 'windows'
   # First, create a .def file listing all the symbols a plugin should expect to have
   # available in qemu
   win32_plugin_def = configure_file(
-    input: files('qemu-plugins.symbols'),
+    input: qemu_plugin_symbols,
     output: 'qemu_plugin_api.def',
     capture: true,
     command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
diff --git a/scripts/qemu-plugin-symbols.py b/scripts/qemu-plugin-symbols.py
new file mode 100755
index 00000000000..e285ebb8f9e
--- /dev/null
+++ b/scripts/qemu-plugin-symbols.py
@@ -0,0 +1,45 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+#
+# Extract QEMU Plugin API symbols from a header file
+#
+# Copyright 2024 Linaro Ltd
+#
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import re
+
+def extract_symbols(plugin_header):
+    with open(plugin_header) as file:
+        content = file.read()
+    # Remove QEMU_PLUGIN_API macro definition.
+    content = content.replace('#define QEMU_PLUGIN_API', '')
+    expected = content.count('QEMU_PLUGIN_API')
+    # Find last word between QEMU_PLUGIN_API and (, matching on several lines.
+    # We use *? non-greedy quantifier.
+    syms = re.findall(r'QEMU_PLUGIN_API.*?(\w+)\s*\(', content, re.DOTALL)
+    syms.sort()
+    # Ensure we found as many symbols as API markers.
+    assert len(syms) == expected
+    return syms
+
+def main() -> None:
+    parser = argparse.ArgumentParser(description='Extract QEMU plugin symbols')
+    parser.add_argument('plugin_header', help='Path to QEMU plugin header.')
+    args = parser.parse_args()
+
+    syms = extract_symbols(args.plugin_header)
+
+    print('{')
+    for s in syms:
+        print("  {};".format(s))
+    print('};')
+
+if __name__ == '__main__':
+    main()
-- 
2.39.5


