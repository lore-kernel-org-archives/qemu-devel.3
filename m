Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB544D46C19
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtL-0000Df-1B; Wed, 28 Jan 2026 20:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt6-0008St-LN
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:04 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt4-00039C-Hz
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:00 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c56188aef06so173191a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650317; x=1770255117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GM9QG/3GlMmiLf/xxkqAGjro1S1VfOQ9Jr1hSQ4oLaQ=;
 b=CgwKIL7wbueYzp+KozmYeKfe0i6MkfR5qDc9aaz3f99Hw7o6YVyWfQ6bnvK/YdKoKj
 9/AQXOXp0KYVLa+3fto1sKLPpZDgYSjXYyQgyVuyuAvQsciWuoXbYb1VoIhYmyAhyArG
 pvzSO+6J0SIEabns1Q7D4N7+dcSF7koxjqMfNMAA+aA7pALd6QmOmFNK4GlR2dr81X/D
 TFewpB76sZw5Pbbapw9Dk9wd+caxpoe9hJwaV/kQPaos401IBxFB+38XCd6ARDBP/lE2
 CNZOINN6LWbAJrY85gJHdML9Fj3zN889q1OFmqd4u8NIxRUBGeIiva754KyFUbAwwdFd
 GT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650317; x=1770255117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GM9QG/3GlMmiLf/xxkqAGjro1S1VfOQ9Jr1hSQ4oLaQ=;
 b=NfH857foBYDZTCSsjqYcvSC0tQKJFagjIEpwokD6eHS5NHlztuV9faokCBE7kSd5OB
 rleAXp9ZKRk3CFXxYoUKcfinWpF/E09cJCX1Ey/IqL1f/KMHvHc2qjdvXkJkch/fhMy/
 O2mlLfmEmneyZtkSthP1OMn3W+ounNvwC8ySvRi1mzgTmMJTpxfTC8J0UUpcQ3aNL5VL
 4WbGG9CTTESrHZI2gs9of5SGCZvydhLBgr9hvZXA7n0v11PfZxL5Wdpm1qpy5bc0e8Gv
 IU8hES+O71bNh4D+4D1I4SvVyUiOFPzOyNmjsH7Bn4vShCfrkrDdJDWpMegSpypurYCM
 KRLg==
X-Gm-Message-State: AOJu0YwKJYK4asS/RC730unhXulNLEJDYlyo9FuXu+w5S0OQ+ACLjy3P
 Q5gjhJIJDc/TkMQHUabu3P9gWOxq7CCYBAknwfGJHe24Fi365dC/ylvSzpsMGxe1oujnotPWv4d
 TQbqe
X-Gm-Gg: AZuq6aJVXBRKzrjFlqDkIJOwV1UPfMRjiP+opSv4BarU19AXlJOaqL+Qz+dSl8Ueszs
 T3IYdM6MeZrr6U123t0xIBCK1ut6gWtui5o05BvHoPJ+fox71pz1o3J6neh+dHNux8OhrgFAxTa
 wah7OHAKxSoNdG2AMVxW8jVlBaFlz2oVOJZWjKfrO9VhbwG+AtP1iEhIVTG1b2unhMZnXFVoYQu
 1zx88muE6l0K7BFDtpIKjddYLR3cDr/QV1jD1I9uXSLm1ofQWq0z0P3WmwhnytUW3bDOUEOX/tq
 BQiquBCUjeePcmxq3vmj4nJLpLBtGy86AdHxxcflntI5ny26YONHS71VHAlLRDe2Mgx0L28QMPQ
 EfYxeePAhmqCKmHR7ZzDiOryEvCNieAr0LeHAZK3zWxqxouVLvrR9tiQDzy0JJFyKJpXhvl4OiK
 okXY+IXuCqST1hjxp2nVdotfwgA47WQAJPlhFqj5QzlC4Nfp22AMffHqy1/9CemjNM
X-Received: by 2002:a17:90b:164e:b0:339:eff5:ef26 with SMTP id
 98e67ed59e1d1-353fed87bbbmr5362316a91.30.1769650316664; 
 Wed, 28 Jan 2026 17:31:56 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:56 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 14/20] plugins: move qemu-plugin.h to include/plugins/
Date: Wed, 28 Jan 2026 17:31:28 -0800
Message-ID: <20260129013134.3956938-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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
index 402028bb79e..951bdd9c54f 100644
--- a/meson.build
+++ b/meson.build
@@ -4445,7 +4445,7 @@ endforeach
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
index 91df1e78d2c..55e2040f409 100644
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


