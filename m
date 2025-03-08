Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Dh-00021Q-Mo; Sat, 08 Mar 2025 17:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DX-0001rZ-GZ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DT-0001w9-LV
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cef0f03cfso1458115e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471217; x=1742076017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHPgkE2VKXbWtAo5xz8P5MmrKJsVMZHVheDnuaENWnM=;
 b=dwLvrLRskLN8WDa6M/mroDakCXr+g4XTcZmNHtHLDkRpt9UlpaQ0HskQ04F4oXVLly
 E6PsB2ggcbSgmdlGnumS+FTBYzb6/elWxTkTmBfnsegCwUmeQ2NkYefbxeGRr1WHz3HR
 L7YxxwtLDDZsHk1fseS38e5MWE+HBhKoPkQj9KNYeDB2pbIOqLNlNeScvPp1VT7dYPer
 tYAXPb0TtdVjsQR1Nuowb7p4tghIJ6efeycGPNzc3bhRKtiaB49VziG/7QgbXschdD4D
 Yl5ptPsCCE7Vff0GU7Weaiovp5++LTn/WVFN2ncbukAcdlUX8J498GdW8MvimumTRcZB
 +SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471217; x=1742076017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHPgkE2VKXbWtAo5xz8P5MmrKJsVMZHVheDnuaENWnM=;
 b=gA1RQmLqFh/tBqJF0I9LL99Z1qMLpWKRiTXjAy6YvNzEG3A2M1OxoFojHoqtGlaBKk
 W1uW29yYnJb4ApKSbhG7Sqe9noC/T5GmvSTPnUfpnQjKy2pbZgu9gbSTZL+IIMYCJUw+
 zpKEb+RCYfrX111vI8SQs7rxftTBKLucl9Oij1S8xO3IJ5I6AawQWeYqvSBjubr3eurE
 fcDYLNTEYC2lt2LD9gSdFeOFmf1qyABjvreEr34Rd9Hj07Gquog7Z3PIw3ia1gnyKOC9
 c0vUhLImzDdoZ/qpi9DXwS61MjGfCyR9/7WHBlcIJmUc53hr8/8QjymfTe6IiAIZlxiA
 F9jQ==
X-Gm-Message-State: AOJu0Yz/I212uFxHTdp6WT/nqEGtnIw18fqVEn5oNsqDsyMinpEcQH0m
 jhdvcxJgruxMTlc+wskhNE2WCUUS+Mxq0XjcLCrddI2FNJkPYSxiAR7B6CKXsVI9ZW2kcb6+Qky
 K
X-Gm-Gg: ASbGncsIz7dCd3HF+H7FtJiJxROFSknrjrU8vrX/vyWmyNS9x9HCO7+2bQ+8iYvUYvm
 HTi2vMSLMWrwvnrCbvZMaUSeGqFnYK3YqrNiUN/llUJj8gAS/EhQ5Hu1yzPcinNYW90f2r9C5lp
 0rMXtkVcDI3TJFyPA++dTCNt8mVwVvXVHNdkBMsNh1I2jqfHRbfJ33bi+/ag/5hGE8ACse1dTCn
 b1Xjk0yOsTvvrPYu6yElWPj6Q7I0JnsLo7siIAuzYTbyF4ExdKvKvIsp5tumbOLJEMJVep7cwWS
 TJdqBeLG6S/f8Sy8UyqBEinI8of1CU7eI8nqum3I1fdKlDw=
X-Google-Smtp-Source: AGHT+IH2QYaq1dOEcUUCD645qS8VQpK3XpFcTekjvlXghjqqhWQxYwuF7K/nQlZ+3hggOuyvnqEV0g==
X-Received: by 2002:a05:600c:3b92:b0:43b:c7ad:55c2 with SMTP id
 5b1f17b1804b1-43c5a5e9853mr49580275e9.6.1741471217377; 
 Sat, 08 Mar 2025 14:00:17 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd948c1bsm94024045e9.36.2025.03.08.14.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA2D560B06;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/31] plugins/loader: compile loader only once
Date: Sat,  8 Mar 2025 21:53:20 +0000
Message-Id: <20250308215326.2907828-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

There is very little in loader that is different between builds save
for a tiny user/system mode difference in the plugin_info structure.
Create two new files, user and system to hold mode specific helpers
and move loader into common_ss.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-26-alex.bennee@linaro.org>

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 9ed20b5c41..6fbc443b96 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -119,4 +119,10 @@ struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
 
 void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
 
+/**
+ * qemu_plugin_fillin_mode_info() - populate mode specific info
+ * info: pointer to qemu_info_t structure
+ */
+void qemu_plugin_fillin_mode_info(qemu_info_t *info);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/loader.c b/plugins/loader.c
index 827473c8b6..7523d554f0 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -31,9 +31,6 @@
 #include "qemu/memalign.h"
 #include "hw/core/cpu.h"
 #include "exec/tb-flush.h"
-#ifndef CONFIG_USER_ONLY
-#include "hw/boards.h"
-#endif
 
 #include "plugin.h"
 
@@ -300,14 +297,8 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     info->target_name = target_name();
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
     info->version.cur = QEMU_PLUGIN_VERSION;
-#ifndef CONFIG_USER_ONLY
-    MachineState *ms = MACHINE(qdev_get_machine());
-    info->system_emulation = true;
-    info->system.smp_vcpus = ms->smp.cpus;
-    info->system.max_vcpus = ms->smp.max_cpus;
-#else
-    info->system_emulation = false;
-#endif
+
+    qemu_plugin_fillin_mode_info(info);
 
     QTAILQ_FOREACH_SAFE(desc, head, entry, next) {
         int err;
diff --git a/plugins/system.c b/plugins/system.c
new file mode 100644
index 0000000000..b3ecc33ba5
--- /dev/null
+++ b/plugins/system.c
@@ -0,0 +1,24 @@
+/*
+ * QEMU Plugin system-emulation helpers
+ *
+ * Helpers that are specific to system emulation.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+#include "hw/boards.h"
+
+#include "plugin.h"
+
+void qemu_plugin_fillin_mode_info(qemu_info_t *info)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    info->system_emulation = true;
+    info->system.smp_vcpus = ms->smp.cpus;
+    info->system.max_vcpus = ms->smp.max_cpus;
+}
diff --git a/plugins/user.c b/plugins/user.c
new file mode 100644
index 0000000000..250d542502
--- /dev/null
+++ b/plugins/user.c
@@ -0,0 +1,19 @@
+/*
+ * QEMU Plugin user-mode helpers
+ *
+ * Helpers that are specific to user-mode.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019-2025, Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+#include "plugin.h"
+
+void qemu_plugin_fillin_mode_info(qemu_info_t *info)
+{
+    info->system_emulation = false;
+}
diff --git a/plugins/meson.build b/plugins/meson.build
index d60be2a4d6..f7820806d3 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -57,8 +57,13 @@ if host_os == 'windows'
     command: dlltool_cmd
   )
 endif
+
+user_ss.add(files('user.c'))
+system_ss.add(files('system.c'))
+
+common_ss.add(files('loader.c'))
+
 specific_ss.add(files(
-  'loader.c',
   'core.c',
   'api.c',
 ))
-- 
2.39.5


