Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D791D29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufM-0006p7-Sq; Mon, 19 Jan 2026 14:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufK-0006nc-LN
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufI-0001UB-Hh
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a3e89aa5d0so45546195ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849911; x=1769454711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7jTI226rULEenFWR/jaa3SSAyZLW7ymCONJzGfrIrs=;
 b=q+AQOSKQ6968mZfZ0RV2Z9dUWow3rBbaOY+Zp1qLKsNnsOu/kKTBrfmDaE9Y50nqAf
 c6EC6lX57/yzcycZ8orxDmFc9DIzrmkVyphV1gQc9rDKbfPoB7g2Zb492DRu/Y1G8F9x
 ktE0st9VcRnNlf+n0ImrijQ+2CLsmt7evHA0F3+7XWM1TGMZU+uApPscWtHFfSH0b5q8
 thxSPWP7ztK5NxHUsiWuYsxVzsf8rZKYiSi5w0Q0eMS+yMfBneaMCGacFlA7zhc54EMu
 K1ujCcc7e9S7FOSc/cKfkhB0D/B/LxBzMVPBGOTgYpx2yuKd7f7PZMvTlB5SQzU1XLJY
 Hdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849911; x=1769454711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i7jTI226rULEenFWR/jaa3SSAyZLW7ymCONJzGfrIrs=;
 b=besOh/AyefzKk7bnC3wI0/6Ajdel4VnjXXD14K8n/FnogFZ0NxY2cYzs2gwkQlDE8O
 GG1CTm7QIDWfEMSb/N21C7zqteAiBwb2+YWLZ06NdJINiALW/k7M5+RH5eFmWbh//qQf
 Ujhp9twIAYha4NV2amLS6ywYWOyU9iifNZ/eezOXtXc8BQCrorrwgqmOmMtsHzRFUUJC
 Mkbhro47+j+0RtRToBucn5HOkVICgZFm/dSmKQ3hwOVZc8PqyrQveQcszy4djaKd1i3N
 ODYDPFPYlBqMDIkLZpEfLN6gsdMKE9duS3/8D7rqWOfwWuWb/kkCRcsHtmRWsbct1Hbx
 Hs8w==
X-Gm-Message-State: AOJu0YwWzQu0WUZ9C2TESjRFKwgezwlwt4hubu27Ggr3uQ18JSn2tgui
 fdQdBU/t1yT1qT+n2I7PEvfvy0iGhcD4JHi4M7pRSYo9wDEkj7uZCAO1nOxlh76kndnTXebtuDb
 ZfKOm
X-Gm-Gg: AZuq6aLzxrANlL9sKRs+1HVJ0emjVI2zLOrCGHuTrI/oa8uFuoMacQmF/d4URx/ZsHf
 Gk0H5dwJ5iPWrh+Ul4uMovtLiXYqRfP88k0dbbKe6yudZcOZ+cEQ3/umEYBEO5khOqj53prLagf
 qiGaGfKBtiM8xoacl6VB19CyFV0EWNZ8U/jhiJVqd4CQQ7tzdCqBTvvD12Hb/L/YUS04LBNq4Yk
 +XCjhg0WtbLvQS3MvvWrxOj7eV11K4AXXrcHvvbP5a+JamHr7O1E56UjR1FvFqPzdIYjldpYfvT
 VVl1ot4Ths4SDcuNrhNlAl5bThCuvs/Wt/qNsGurEL2Nj403/ELpvsyqQLovdRwr/4UsvfzNA84
 eiKF+F/S4jNj1SXPWvFyw88Pgdw1nUEjw/6H09Ysx6Q0QDXKOF+DUVUiupxVZSvFzUJ5yfa6ukR
 lLBRWSZipwR9oI2DKJZjFAwnrZB9gNTCrbCUa3Moj0n4JU+Ohwmk8+SH5laK9m6YJ9
X-Received: by 2002:a17:902:c951:b0:2a1:3ade:c351 with SMTP id
 d9443c01a7336-2a7174efcd0mr141827195ad.2.1768849910800; 
 Mon, 19 Jan 2026 11:11:50 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:50 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 06/11] plugins: move qemu-plugin.h to include/plugins/
Date: Mon, 19 Jan 2026 11:11:32 -0800
Message-ID: <20260119191138.811069-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This change has two benefits:
- ensure plugins can't include anything else from QEMU than plugins API
- when compiling a C++ module, solves the header conflict with iostream
  header that includes transitively the wrong ctype.h, which already
  exists in include/qemu.

By Hyrum's law, there was already one usage of other headers with mem
plugin, which has been eliminated in previous commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/tcg-plugins.rst              | 4 ++--
 meson.build                             | 2 +-
 include/{qemu => plugins}/qemu-plugin.h | 3 ---
 include/qemu/plugin.h                   | 2 +-
 plugins/core.c                          | 2 +-
 plugins/meson.build                     | 6 +++---
 scripts/clean-includes                  | 2 +-
 7 files changed, 9 insertions(+), 12 deletions(-)
 rename include/{qemu => plugins}/qemu-plugin.h (99%)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 9463692c411..f48c32bd844 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -166,7 +166,7 @@ Plugin API
 ==========
 
 The following API is generated from the inline documentation in
-``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
+``include/plugins/qemu-plugin.h``. Please ensure any updates to the API
 include the full kernel-doc annotations.
 
-.. kernel-doc:: include/qemu/qemu-plugin.h
+.. kernel-doc:: include/plugins/qemu-plugin.h
diff --git a/meson.build b/meson.build
index 6f02547df9b..3ed62a406b7 100644
--- a/meson.build
+++ b/meson.build
@@ -4443,7 +4443,7 @@ endforeach
 # Other build targets
 
 if get_option('plugins')
-  install_headers('include/qemu/qemu-plugin.h')
+  install_headers('include/plugins/qemu-plugin.h')
   if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
diff --git a/include/qemu/qemu-plugin.h b/include/plugins/qemu-plugin.h
similarity index 99%
rename from include/qemu/qemu-plugin.h
rename to include/plugins/qemu-plugin.h
index e44f863d839..78872716246 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -2,9 +2,6 @@
  * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
  * Copyright (C) 2019, Linaro
  *
- * License: GNU GPL, version 2 or later.
- *   See the COPYING file in the top-level directory.
- *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index cea0a68858b..cdd4f68c0c1 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -8,7 +8,7 @@
 #define QEMU_PLUGIN_H
 
 #include "qemu/config-file.h"
-#include "qemu/qemu-plugin.h"
+#include "plugins/qemu-plugin.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "qemu/option.h"
diff --git a/plugins/core.c b/plugins/core.c
index b4b783008f7..3f66533d749 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -15,7 +15,7 @@
 #include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/plugin.h"
-#include "qemu/qemu-plugin.h"
+#include "plugins/qemu-plugin.h"
 #include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/rcu.h"
diff --git a/plugins/meson.build b/plugins/meson.build
index 4318e3a1671..34643e2cea3 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -3,7 +3,7 @@ if not get_option('plugins')
 endif
 
 qemu_plugin_symbols = configure_file(
-  input: files('../include/qemu/qemu-plugin.h'),
+  input: files('../include/plugins/qemu-plugin.h'),
   output: 'qemu-plugin.symbols',
   capture: true,
   command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
@@ -62,12 +62,12 @@ endif
 
 if host_os == 'windows'
   plugins_deps = declare_dependency(sources: [files('win32_linker.c')],
-                                    include_directories: '../include/qemu',
+                                    include_directories: '../include/plugins',
                                     link_with: win32_qemu_plugin_api_lib,
                                     link_args: win32_qemu_plugin_api_link_flags,
                                     dependencies: glib)
 else
-  plugins_deps = declare_dependency(include_directories: '../include/qemu',
+  plugins_deps = declare_dependency(include_directories: '../include/plugins',
                                     dependencies: glib)
 endif
 
diff --git a/scripts/clean-includes b/scripts/clean-includes
index 25dbf16c021..3fae8e00e67 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -128,7 +128,7 @@ for f in "$@"; do
       ;;
     *include/qemu/osdep.h | \
     *include/qemu/compiler.h | \
-    *include/qemu/qemu-plugin.h | \
+    *include/plugins/qemu-plugin.h | \
     *include/glib-compat.h | \
     *include/system/os-posix.h | \
     *include/system/os-win32.h | \
-- 
2.47.3


