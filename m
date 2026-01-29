Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE7D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyV-0004tv-Uy; Thu, 29 Jan 2026 12:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyS-0004qB-Pp
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:32 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyQ-0000g2-QU
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:32 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81ecbdfdcebso731339b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708309; x=1770313109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1iWVIWfGVLKilqz3ftc9Tmo4SlNlCW4u2SLlHd8K58=;
 b=ZFrL2bbTzyE8Jxhot1NNO0Yju/kV4oAlvruzLC3g0VyEcvEayTyqk+pnyx7PSlceuH
 Ct0J7nHahVbSfbRDDfw3wZNqwX4j8he1I2avKX137QGiaKK7yJOaCaF6qE0m1KlSSOeY
 xD4u0JfCzrZrdRO5njTswKIO85QFbzVzuW/M3XH4EsbYwWRKPYJWAF1iAQwrgpq0f8R+
 p0UJlOSVcLIUu8a0c5/uVxvfANOVqJA/GNXKpPxu/k92NpYQ/aqUnMWD2KXJLx6r+S6l
 0mv3PDasRP8B/IRZusN1sfm7SgqxPEiUc4IDLttbmiCfOTCOatobLjVYoGrLyBoMK1yL
 4uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708309; x=1770313109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C1iWVIWfGVLKilqz3ftc9Tmo4SlNlCW4u2SLlHd8K58=;
 b=GYbFYPvcGp4RHJG39LA8RUf/CQxWidr3Lgz2AUZHpLO0Nq7pQarnATUx4Fsmwvf1Pk
 V/kqf8ug/CE6W6pguEr6glcv8dn6QjCQ4UIPUW9Xb8iMcXOYooiUVdGcanI/r7Pa94D1
 0Wwj152SYpwK1qQKOjbpetBSog726QjBXUOH1zw4FNgS9EFbeI86C/Uy+ingnmWfQH8N
 k7kRi4An9Z3YUMzLH4F+mXAT9hJhy1q5zaBcSAl70LRhJxhw19aPj1YABBArIsQBuEfi
 xcBDrGwfanv57hrEgpBImcNVUtZUpAfj8j27BXfsaqGh8PweCj95MXnCAbeyg3JnZVL/
 cXpA==
X-Gm-Message-State: AOJu0YwaLvKGBCP2DHV+BpsSDMXO7EAzPkf73FuOrt1Bcl9ePvyLGJTx
 Ed3l0kmw5qKQujtvw/UTjuPJmJ/gaxyAXaCRJgP8nlC8wQRwvLfoTBDQyEqnBO6FdSE7GCQ7R+c
 ggtcF
X-Gm-Gg: AZuq6aJRRupmAuqR55ud+f3ij83E+qJjlJaiml0WoK184HFTeWozrIJIsEOh0WXaOiW
 GkSjtb/MK2o8tbrqu1wv4SAuDERk+DJnXV/463kvt7zK2rPmxcNKx9ulkFTZ3Af8bKVyiQ53krl
 LxfPrFnX4NudDk1Lci3DW02atf2DthosHgZiJAqOPSni4q/9V2lE4dh0IR9bthrdN7D+DH07SbH
 fCM7l2DuBj+YXOL6WoDYbLxdB+Iuin1zlHYVSU7oZ550qVIlZ984JSWn5KMdn0qUBefLa4+3qJr
 jr6WhgoQ1xyEOQZHl79yFWYHoc3tW4ASFcdl5BOL0SUa7yTTQjL/dd5odaGaRsdddmfTAUqIbzs
 T6HN0RK+gZa07SAL3c51amdTdsbmMaB47ZUWJJJ5tOLa/SueK4zZYlPJKD9hyQC6iA85AJmvk1h
 ZKnDOCscJ1Y+qTum9CUAFxGqWFyoLSyQfrVGn0pReUj6c3u1OZObdMQWTJQzEBGzR3
X-Received: by 2002:a05:6a00:1252:b0:821:8250:8ded with SMTP id
 d2e1a72fcca58-823692ef096mr7154793b3a.65.1769708309385; 
 Thu, 29 Jan 2026 09:38:29 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 15/21] plugins: move qemu-plugin.h to include/plugins/
Date: Thu, 29 Jan 2026 09:38:01 -0800
Message-ID: <20260129173811.138036-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-7-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/tcg-plugins.rst              | 4 ++--
 meson.build                             | 2 +-
 include/{qemu => plugins}/qemu-plugin.h | 3 ---
 include/qemu/plugin.h                   | 2 +-
 plugins/core.c                          | 2 +-
 plugins/meson.build                     | 6 +++---
 6 files changed, 8 insertions(+), 11 deletions(-)
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
index 82e0188b0bc..23252afc7d0 100644
--- a/meson.build
+++ b/meson.build
@@ -4446,7 +4446,7 @@ endforeach
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
index 7f449d1b50a..17a834dca90 100644
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
index b74a7d0811b..ddd77bd82c9 100644
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
index 85fabf9ec81..42fd9865930 100644
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
 
-- 
2.47.3


