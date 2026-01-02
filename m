Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02665FA3751
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0T-0006kc-Uw; Fri, 02 Jan 2026 16:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzi-0006fx-WF
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:44 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzh-0000Jl-73
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:38 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso19488045b3a.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390456; x=1767995256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4hbow1zviH+bWh7+b+fqV3JFTVXLR9m8ieoHmc4Fac=;
 b=SWOPPREGfOYuf+GDEfsIqIZyeHHicIPqjFAkHTbmaGdF1u3scP6RU5yFqC8NoQaeXK
 Z33obRO+oidCPP3M7Uajhv0BLbHmw/+55TyC3ayk8O+0il1N2m1Y39K7odKLJ8Z9ZGrb
 462RzuWNlAxVrk9RhIeg+FiS0b10qH2ntKIR1miTsB3lCIxVDUSGYb6Qw2gMwYY1Aqxp
 OKZaS12xl7qHBUDh9I4TDPagMEfHWi3ZNWZ44VkoUZsBK8zevzKp17tm4l+eTD8BeUpm
 oliCjHy8zMqIZnNSpufZAzo4Pho+1Nro80cCVktOhnPFpM6hwjoM/+JvHY3XcjqSnEI8
 5IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390456; x=1767995256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R4hbow1zviH+bWh7+b+fqV3JFTVXLR9m8ieoHmc4Fac=;
 b=vFudyOaZrXgCePtfPzttvtiAh0HSrXhOy9YRh6ai0O3ciaQ18TfbZicFlwTEq+lKJT
 gh1XQtsfGF8ioAVPh9P82zktV6k0GZFv8g3nDRyS1BxvTqWyLafblayMJ9YH/MZJ56NB
 bCuZzB2Ll6Tvwcbba03MSYoPBJOuHdwKMnYfI/W+ulR5EUNcZxRnIJo4KLVKLIOA05xw
 83rdAyOhMxaWfUcFFTtKkqhUxr263DvqxDrj4hNLl6Stq5v6xXvjYE97li9GiVMIoI/3
 z2rU8SNdn1rxF6wUBMqTw5mair3uGpn+7sQwubP1jO5mOgHEgKbu1Wha2q1y/fQN4Vn2
 KDzA==
X-Gm-Message-State: AOJu0Yzyic3VmbVrgTDd3VLMsUg4uHguQTpwirOBpqzaYkTxAb0WDw68
 o3y8/wgyxocbNxvAUFJUvbWkwM2rwaI2DbkfLpRUgg478tT8bEVmoxbpCdRSeZbHq8DqtLp5CVz
 hOENb
X-Gm-Gg: AY/fxX6FezT+uJj4At4PjoZhF87IHlv2+PIwM2thvrakLm9pRSGQvEBr6V3FEsiZ/Dj
 TQRx47QESnmB6/+eeBkeZUBSz2+12eXd10unyLQ6dpaHoyh6m4lXMgXrV+TEaTt21i22RsBw99k
 NffI8OpKy34xwXYwUHYz/PK6XJHjKde+qzkagQIUva2Q/ZFF+Jn0hf64dsIo1RYweTvoUMzk1Fx
 yJ+zzlAWUd6ooB4abf6kYL/SVYiNvBwlFwsyaIoJ37DN4LJMXhv1ZEmGJGkvkZFpQjbCEEpxDMb
 I4t/RvZ6f6KZmjrrb9nZPCXWc6BjQwF4bh8cLoNQ/e8uatK3eCua+meChV9gsJ5hazHpnCvIkha
 V8PrOBHgr2cv2nuLPje0KLT0o35DP+myJWDGDR0zPS7w/s9agkNAJfmkvI+3o/gnUxEheVLOGWm
 Yo1Km2QdmjvD5TXzkSqMYUAoqZW4eM8RIJzk9x2owwb3gwJ7HTHQxgT1jga+EAXU4y
X-Google-Smtp-Source: AGHT+IF6j2aZSgO3xM2T6ObR+O8IFpLYaekMMtl3lPyIKyrtc9cO3VfyhcMs0ji49NPvmqxNQkJPaA==
X-Received: by 2002:a05:6a20:3d89:b0:34f:ec32:6a3c with SMTP id
 adf61e73a8af0-376a8cbe9d0mr43275220637.28.1767390455557; 
 Fri, 02 Jan 2026 13:47:35 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:35 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/11] plugins: move qemu-plugin.h to include/plugins/
Date: Fri,  2 Jan 2026 13:47:19 -0800
Message-ID: <20260102214724.4128196-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

This change has two benefits:
- ensure plugins can't include anything else from QEMU than plugins API
- when compiling a C++ module, solves the header conflict with iostream
  header that includes transitively the wrong ctype.h, which already
  exists in include/qemu.

By Hyrum's law, there was already one usage of other headers with mem
plugin, which has been eliminated in previous commit.

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
index 3d6c6c702d0..a8fd8e88225 100644
--- a/meson.build
+++ b/meson.build
@@ -4495,7 +4495,7 @@ endforeach
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


